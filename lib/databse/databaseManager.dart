import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseManager{
final CollectionReference studentList =
FirebaseFirestore.instance.collection('studentInfo');
final String uid;
DatabaseManager(this.uid);
Future updateUserData(String PRN,String name) async
{
  return await studentList.doc(uid).set({
  'PRN':PRN,
  'name':name,
  'userType':'student'
  }
  );
}

}
