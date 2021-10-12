import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DatabaseManager {
  final CollectionReference studentList = FirebaseFirestore.instance.collection(
      'studentInfo');
  final CollectionReference eventList = FirebaseFirestore.instance.collection(
      'eventInfo');
  final firestoreInstance = FirebaseFirestore.instance;

  final String uid;

  DatabaseManager(this.uid);

  Future updateUserData(String PRN, String name) async
  {
    return await studentList.doc(uid).set({
      'PRN': PRN,
      'name': name,
      'userType': 'student'
    }
    );
  }

  // Future addEvent(String head, String purpose, DateTime date,
  //     TimeOfDay time) async
  // {
  //   var prn = await FirebaseFirestore.instance.collection('studentInfo').doc(uid).get();
  //   return await eventList.add({
  //     'Head': head,
  //     'purpose': purpose,
  //     'Date': date,
  //     'Time': time.hour,
  //     'Status': 'NA',
  //     'Organizer':prn.get('PRN'),
  //   }
  //   );
  // }
  Future addEvent(String title,String club,String desc,String dept,String venue,DateTime start,DateTime end,String color,String addInfo) async
  {
    var prn = await FirebaseFirestore.instance.collection('studentInfo').doc(uid).get();
    return await eventList.add({
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
  }
  void getEvents(String dep)
  {
    print('showing events');
    try {
      firestoreInstance.collection("eventInfo").where('Status',isEqualTo:'NA').where('Department',isEqualTo: dep).get().then((querySnapshot)
      {
        querySnapshot.docs.forEach((result) {
          print('result:'+result.data().toString());
        });
      });
    }
    catch(e)
    {
      e.toString();
    }
  }
  Future checkStatus()
  async {
    print('showing status');
    try {
      var prn = await FirebaseFirestore.instance.collection('studentInfo').doc(uid).get();
      firestoreInstance.collection("eventInfo").where('Organizer',isEqualTo:prn.get('PRN')).get().then((querySnapshot)
      {
        querySnapshot.docs.forEach((result) {
          print(result.data());
        });
      });

    }
    catch(e)
    {
      e.toString();
    }
  }



}
