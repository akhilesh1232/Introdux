import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  static const routeName = '/detailpage';
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
        body: Stack(
            children: <Widget>[
            IconButton(onPressed: () {
      },
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        padding: EdgeInsets.all(40),),
      Text('Event Details', textAlign: TextAlign.left,
        style: TextStyle(color: Colors.white,
          fontSize: 30, fontWeight: FontWeight.bold,
        ),),
      SizedBox(height: 30,),

    ],
    ),
      );
  }
}
