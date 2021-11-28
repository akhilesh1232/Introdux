import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
//class DatabaseManager has collection references & firestore instance as data members also
//functions for updating user data , adding events & status checking of events as member functions.
class DatabaseManager {
  final CollectionReference studentList = FirebaseFirestore.instance.collection(
      'studentInfo');
  final CollectionReference eventList = FirebaseFirestore.instance.collection(
      'eventInfo');
  final firestoreInstance = FirebaseFirestore.instance;
  final String uid;

  DatabaseManager(this.uid);
//updating user data in firebase during sign uup
  Future updateUserData(String PRN, String name) async
  {
    var status = await OneSignal.shared.getDeviceState();
    String? tokenId = status!.userId;
    print('tokenId:'+tokenId.toString());
    await studentList.doc(uid).set({
      'PRN': PRN,
      'name': name,
      'userType': 'student',
       'tokenId':tokenId, //for notification sending
    }
    );
  }

  //Add event in the firebase when students asks for permission of authority
  Future addEvent(String title,String club,String desc,String dept,String venue,DateTime start,DateTime end,String color,String addInfo) async
  {
    //get PRN of currently logged in student
    var prn = await FirebaseFirestore.instance.collection('studentInfo').doc(uid).get();
    print('addding event');
     await eventList.add({
      'Title': title,
      'Club-Name': club,
      'Description': desc,
      'Department':dept,
      'Venue':venue,
      'Start-Date':start,
      'End-Date':end,
      'Color':color,
      'Additional-Info':addInfo,
      'Status': 'NA',
      'Organizer':prn.get('PRN'),
    }
    );
     //sending notifications using onesignal
    var snapshot=await FirebaseFirestore.instance.collection('studentInfo').where('dept', isEqualTo: dept).get();
    List <String> tokenIdList=[snapshot.docs.first.get('tokenId')];
    print('DBM tokenIdList:'+tokenIdList.toString());
  String contents = prn.get('PRN') + ' is asking for your permission to conduct event - '+title;
  String heading='Event Permission';
    print('sending notification');
    print('sending to:'+tokenIdList.toString());
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": '73a8540a-50bd-4140-b43e-3e6f3d972db3',// the App Id that one get from the OneSignal When the application is registered.
        "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.
        "android_accent_color":"FF80325F",
        "small_icon":"assets/logo2.png",
        "large_icon":"assets/logo2.png",
        "headings": {"en": heading},
        "contents": {"en": contents},
      }),
    );
  }
}
