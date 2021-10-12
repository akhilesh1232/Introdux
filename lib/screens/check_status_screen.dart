import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/databse/databaseManager.dart';
import 'package:myapp/screens/home_screen.dart';
class CheckStatus extends StatefulWidget {
  final String? org;
  CheckStatus({ this.org});
  @override
  _CheckStatusState createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
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
              Text('Your Events', textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white,
                  fontSize: 30, fontWeight: FontWeight.bold,
                ),),

            ],
          ),
          SizedBox(
            height:500,width: 400,
            child: StreamBuilder(
              stream:
              FirebaseFirestore.instance.collection('eventInfo').where('Organizer',isEqualTo:'${widget.org}').snapshots(),
              builder: buildUserList,
            ),
          ),
        ],),
    );
  }
  Widget buildUserList(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data!.docs[index];
          var s=user.get('Status');
          String str='';
          if(s=='NA')
            str='Not Acknowledged by Authorities yet.';
          if(s=='G')
            str='Permission Granted , You can start preparations for event.';
          if(s=='D')
            str='Permission Denied.';
          return ListTile(
            // Access the fields as defined in FireStore
            title: Text(
              user.get('Title'), style: TextStyle(color: Colors.white),),
            leading: Icon(Icons.view_headline,color: Color.fromRGBO(255, 76, 41, 0.8),size: 25,),
           subtitle: Text(str,style: TextStyle(color: Color.fromRGBO(255, 76, 41, 0.8)),),
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
}
