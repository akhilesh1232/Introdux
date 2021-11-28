import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart';
//stateful widget
class BookingAuthScreen extends StatefulWidget {
  final String? value;
  BookingAuthScreen({ this.value});
  static const routeName = '/booking_auth';
  @override
  _BookingAuthScreenState createState() => _BookingAuthScreenState();
}
class _BookingAuthScreenState extends State<BookingAuthScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  static String uid = '';
  void initState()  {
    final User? user = auth.currentUser;
    uid = user!.uid;
  }
  //shows a list of events whose permission status is not yet acknowledged
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
      body:
          Column(
            children: [
              SizedBox(height: 30,),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new HomeScreen()));
                  },
                    icon: Icon(Icons.arrow_back),
                    color: Color.fromRGBO(255, 76, 41, 0.8),
                    padding: EdgeInsets.all(20),),
                  SizedBox(width: 30,),
                  Text('Events', textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                      fontSize: 30, fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
          SizedBox(
            height:500,width: 400,
            child: StreamBuilder(
              stream:
              FirebaseFirestore.instance.collection('eventInfo').where('Status',isEqualTo:'NA').where('Department',isEqualTo:'${widget.value}').snapshots(),
              builder: buildUserList,
            ),
          ),
        ],),
    );
  }

  //This widget shows the details of selected event by authority. There authority will have 2 options either to
  //grant or deny the permission.

  Widget buildUserList(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data!.docs[index];
          return ListTile(
            // Access the fields as defined in FireStore
            title: Text(
              user.get('Title'), style: TextStyle(color: Colors.white),),
            onTap:()=> gotodetails(user),
            leading: Icon(Icons.view_headline,color: Color.fromRGBO(255, 76, 41, 0.8),size: 25,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Color.fromRGBO(255, 76, 41, 0.8),),
          );
        },
      );
    } else
    if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No users found."),
      );
    } else {
      // Still loading
      return CircularProgressIndicator();
    }
  }
//redirecting to detail page
  gotodetails(DocumentSnapshot post) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailpage(post:post,)));
    }
  }
//event details page
class Detailpage extends StatefulWidget {
  final DocumentSnapshot post;

  Detailpage({required this.post});
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  String textString='';
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
        body:
        Center(
          child: Container(
            width: 310,
            height: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    // SizedBox(height: 100,),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      //padding: EdgeInsets.all(40),),
                    ),
                    SizedBox(width: 15),
                    Text('Event Details', textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white,
                        fontSize: 30, fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
                SizedBox(height: 30,),
                Text('Title : ' + widget.post.get('Title'),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 10,),
                Text('Description : ' + widget.post.get('Description'),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 10,),
                Text('Club : ' + widget.post.get('Club-Name'),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 10,),
                Text('Organizer: ' + widget.post.get('Organizer'),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 10,),
                Text('Venue : ' + widget.post.get('Venue'),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 10,),
                Text('Start Date & Time : ' +
                    getDate(widget.post.get('Start-Date')),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 10,),
                Text(
                  'End Date & Time : ' + getDate(widget.post.get('End-Date')),
                  textAlign: TextAlign.justify, style: TextStyle(
                  color: Colors.white,
                ),),
                SizedBox(height: 10,),
                Text('Additional Information : ' +
                    widget.post.get('Additional-Info'),
                  textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white,
                  ),),
                SizedBox(height: 20),
                Row(
                  children: [
                    OutlinedButton(onPressed: (){
          widget.post.reference.update({'Status': 'G'});
          setState(() {
            textString='Granted permission for the event';
          });
          sendNotification('Granted');
          },
                      child: Text(
                          'Grant Permission', style:
                      TextStyle(color: Colors.white,)),
                      style: OutlinedButton.styleFrom(shape: StadiumBorder(),
                        side: BorderSide(
                          width: 2.0, color: Color.fromRGBO(255, 76, 41, 0.8),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0,8),
                      child: OutlinedButton(onPressed: (){
    widget.post.reference.update({'Status': 'D'});
    setState(() {
      textString='Denied permission for the event';
    });
    sendNotification('Denied');

    },
                        child: Text(
                            'Deny Permission', style:
                        TextStyle(color: Colors.white,)),
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(width: 2.0, color: Color.fromRGBO(
                              255, 76, 41, 0.8),),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(textString,style: TextStyle(color: Colors.grey),textAlign:TextAlign.center,),
                ),
              ],),
          ),

        ),
      );
  }
//formatting date appropriately
  String getDate(Timestamp t) {
    DateTime d = t.toDate();
    return DateFormat.yMMMd().add_jm().format(d);
  }
  //sending notification to students if the permission is granted or denied
  Future sendNotification(String status) async
  {
    var snapshot=await FirebaseFirestore.instance.collection('studentInfo').where('PRN', isEqualTo:widget.post.get('Organizer')).get();
    List <String> tokenIdList=[snapshot.docs.first.get('tokenId')];
    print('Auth tokenIdList:'+tokenIdList.toString());
    String contents = widget.post.get('Department')+ ' authority has '+status+' permission '+'to the event - '+widget.post.get('Title') ;
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
        "app_id": '73a8540a-50bd-4140-b43e-3e6f3d972db3',//kAppId is the App Id that one get from the OneSignal When the application is registered.
        "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.
        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color":"FF80325F",
        "small_icon":"assets/logo2.png",
        "large_icon":"assets/logo2.png",
        "headings": {"en": heading},
        "contents": {"en": contents},
      }),
    );
  }

}






