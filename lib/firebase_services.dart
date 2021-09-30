import 'package:cloud_firestore/cloud_firestore.dart';
import 'event.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FirebaseService {
  late FirebaseFirestore _firebaseFirestore;

  FirebaseService() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  uploadEventData(Events a) {
    _firebaseFirestore.collection('EventData').add({
      'title': a.title,
      'organizer': a.organizer,
      'description': a.description,
      'to': a.to,
      'from': a.from,
      'background': a.background.value,
      'department': a.department
    });
  }

  FirebaseFirestore getFirebaseFirestoreInstance() {
    return _firebaseFirestore;
  }
}
