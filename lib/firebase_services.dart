import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// class FirebaseService {
//   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   Stream<List<String>> getStringList() {
//     return _firebaseFirestore.collection('testing').snapshots().map(
//         (snapshots) =>
//             snapshots.docs.map((docs) => String.fromJSON(docs.data())).toList());
//   }
// }
