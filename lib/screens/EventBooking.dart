import '../databse/firebase_services.dart';

Future<bool> toUpload(String department, DateTime start, DateTime end) async {
  FirebaseService _firebaseService = new FirebaseService();
  bool returnValue = false;
  DateTime startEvent, endEvent;
  bool c1, c2;
  await _firebaseService
      .getFirebaseFirestoreInstance()
      .collection('eventInfo')
      .where('Department', isEqualTo: department)
      .where('Status', isEqualTo: 'G')
      .get()
      .then((value) => {
    for (int i = 0; i < value.size; i++)
      {
        startEvent = DateTime.parse(value.docs
            .elementAt(i)
            .get('Start-Date')
            .toDate()
            .toString()),
        endEvent = DateTime.parse(value.docs
            .elementAt(i)
            .get('End-Date')
            .toDate()
            .toString()),
        c1 = startEvent.compareTo(start) >= 0 &&
            startEvent.compareTo(end) <= 0,
        c2 = start.compareTo(startEvent) >= 0 &&
            start.compareTo(endEvent) <= 0,
        if (c1 || c2)
          {
            returnValue = true,
          }
      }
  });
  return returnValue;
}
