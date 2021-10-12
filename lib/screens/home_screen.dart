import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/dropdownlist.dart';
import 'package:myapp/screens/booking_auth.dart';
import 'package:myapp/screens/booking_student.dart';
import 'package:myapp/screens/calendar.dart';
import 'package:myapp/services/authentication.dart';
class HomeScreen extends StatefulWidget {

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationService _auth = AuthenticationService();
  Future getData() async{
    print('getting data');
    String userId = (await FirebaseAuth.instance.currentUser)!.uid;
      var snapshot = await FirebaseFirestore.instance.collection('studentInfo').doc(userId).get();
      print(snapshot.get('userType'));
      return snapshot.get('userType');
      }
  Future getDept() async {
    String userId = (await FirebaseAuth.instance.currentUser)!.uid;
    var snapshot=await FirebaseFirestore.instance.collection('studentInfo').doc(userId).get();
    return snapshot.get('dept');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
      body:
      Center(
        child: Container(
          width:300,
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Home screen',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,
          fontSize: 25,fontWeight: FontWeight.bold,
          ),),SizedBox(height:30),
              ElevatedButton(
                onPressed: ()async{
                    dynamic res=await getData();
                    print('result:'+res.toString());
                    if(res.toString()=='student'){
                      Navigator.of(context).pushReplacementNamed(
                          BookingStudentScreen.routeName);
                    }
                    else {
                      dynamic res2=await getDept();
                      print('Department:'+res2.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingAuthScreen(
                              value: res2.toString(),
                            )),
                      );
                    }
                  },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 76, 41,0.8),
                    padding: EdgeInsets.all(6)
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Book Hall',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height:30),
              ElevatedButton(
                onPressed: (){Navigator.of(context).pushReplacementNamed(
                    CalendarWidget.routeName);},
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 76, 41,0.8),
                    padding: EdgeInsets.all(6)
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height:30),
              ElevatedButton(
                onPressed: (){Navigator.of(context).pushReplacementNamed(
                    Dropdownsearch.routeName);},
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 76, 41,0.8),
                    padding: EdgeInsets.all(6)
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Map',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height:30),
              ElevatedButton(
                onPressed: (){signOut();},
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 76, 41,0.8),
                    padding: EdgeInsets.all(6)
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),




//               TextButton(onPressed: () {
//                 signOut();
//               },
//                 style: TextButton.styleFrom(
//                     padding: EdgeInsets.all(15)
//                 ),
//                 child: Text('Log out', style: TextStyle(
//                   color: Colors.black,
//                   decoration: TextDecoration.underline,
//                   decorationThickness: 3,
//                 ),),
//               ),
// TextButton(onPressed: (){
//   Navigator.of(context).pushReplacementNamed(
//       CalendarWidget.routeName);
// }, child: Text('Calendar', style: TextStyle(
//   color: Colors.black,
//   decoration: TextDecoration.underline,
//   decorationThickness: 3,
// ),),),
//
//               TextButton(onPressed: (){
//                 Navigator.of(context).pushReplacementNamed(
//                     Dropdownsearch.routeName);
//               }, child: Text('Map', style: TextStyle(
//                 color: Colors.black,
//                 decoration: TextDecoration.underline,
//                 decorationThickness: 3,
//               ),),),
//
//               TextButton(onPressed: () async{
//                 dynamic res=await getData();
//                 print('result:'+res.toString());
//                 if(res.toString()=='student'){
//                   Navigator.of(context).pushReplacementNamed(
//                       BookingStudentScreen.routeName);
//                 }
//                 else {
//                   dynamic res2=await getDept();
//                   print('Department:'+res2.toString());
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => BookingAuthScreen(
//                           value: res2.toString(),
//                         )),
//                   );
//                 }
//               },
//                 style: TextButton.styleFrom(
//                     padding: EdgeInsets.all(15)
//                 ),
//                 child: Text('Book hall', style: TextStyle(
//                   color: Colors.black,
//                   decoration: TextDecoration.underline,
//                   decorationThickness: 3,
//                 ),),
//               ),
            ],
          ),
        ),

      ),
    );
  }

  void signOut() async {
    await _auth.signOut().then((result) {
      Navigator.of(context).pop(true);
    });
  }
}