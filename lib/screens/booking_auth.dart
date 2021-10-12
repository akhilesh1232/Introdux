import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:Introdux-map-feature/databse/databaseManager.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/databse/databaseManager.dart';
import 'package:intl/intl.dart';

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

  gotodetails(DocumentSnapshot post) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailpage(post:post,)));
    }
  }

class Detailpage extends StatefulWidget {
  final DocumentSnapshot post;
  Detailpage({required this.post});
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
        body:
            Center(
              child: Container(
                width: 300,
                height:600,
                child: Column(
                  children: [
                    Row(
                      children: [
                       // SizedBox(height: 100,),
                        IconButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                        },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          //padding: EdgeInsets.all(40),),
                        ),
                          SizedBox(width:15),
                        Text('Event Details', textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white,
                            fontSize: 30, fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                SizedBox(height: 30,),
                Text('Title : '+widget.post.get('Title'),textAlign: TextAlign.justify,style:TextStyle(
                color:Colors.white,
                ),),
                SizedBox(height: 10,),
                    Text('Description : '+widget.post.get('Description'),textAlign: TextAlign.justify,style:TextStyle(
                      color:Colors.white,
                    ),),
                    SizedBox(height: 10,),
                    Text('Club : '+widget.post.get('Club-Name'),textAlign: TextAlign.justify,style:TextStyle(
                      color:Colors.white,
                    ),),
                    SizedBox(height: 10,),
                    Text('Organizer: '+widget.post.get('Organizer'),textAlign: TextAlign.justify,style:TextStyle(
                      color:Colors.white,
                    ),),
                    SizedBox(height: 10,),
                Text('Venue : '+widget.post.get('Venue'),textAlign: TextAlign.justify,style:TextStyle(
                color:Colors.white,
                ),),
                    SizedBox(height: 10,),
                    Text('Start Date & Time : '+getDate(widget.post.get('Start-Date')),textAlign: TextAlign.justify,style:TextStyle(
                      color:Colors.white,
                    ),),
                    SizedBox(height: 10,),
                    Text('End Date & Time : '+getDate(widget.post.get('End-Date')),textAlign: TextAlign.justify,style:TextStyle(
                      color:Colors.white,
                    ),),
                    SizedBox(height: 10,),
                    Text('Additional Information : '+widget.post.get('Additional-Info'),textAlign: TextAlign.justify,style:TextStyle(
                      color:Colors.white,
                    ),),
                SizedBox(height: 20),
                Row(
                children: [
                  OutlinedButton(onPressed:()=> widget.post.reference.update({'Status':'G'}),
                    child: Text(
                        'Grant Permission',style:
                    TextStyle(color: Colors.white,) ),
                    style: OutlinedButton.styleFrom(  shape: StadiumBorder(),
                      side: BorderSide(width: 2.0, color: Color.fromRGBO(255, 76, 41, 0.8),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(onPressed:()=> widget.post.reference.update({'Status':'D'}),
                      child: Text(
                          'Deny Permission',style:
                      TextStyle(color: Colors.white,) ),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(width: 2.0, color: Color.fromRGBO(255, 76, 41, 0.8),),
                      ),
                    ),
                  ),
                ],
                ),

        ],),
              ),

            ),
      );
  }
  String getDate(Timestamp t)
  {
     DateTime d=t.toDate();
     return DateFormat.yMMMd().add_jm().format(d);
  }
}









