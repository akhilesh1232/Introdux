import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/event.dart';
//class firebase firestore instance as data member
class FirebaseService {
  late FirebaseFirestore _firebaseFirestore;

  FirebaseService() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }
  //returns firebase firestore instance
  FirebaseFirestore getFirebaseFirestoreInstance() {
    return _firebaseFirestore;
  }
}