import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/booking_auth.dart';
import 'package:myapp/screens/booking_student.dart';
import 'package:myapp/screens/calendar.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/nested_dropdown.dart';
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
      // Center(
      //   child: Container(
      //     width:300,
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           SizedBox(height: 40),
      //           Text(
      //             'Home',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,
      //       fontSize: 25,fontWeight: FontWeight.bold,
      //       ),),SizedBox(height:30),
      //           ElevatedButton(
      //             onPressed: ()async{
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
      //             style: ElevatedButton.styleFrom(
      //                 primary: Color.fromRGBO(255, 76, 41,0.8),
      //                 padding: EdgeInsets.all(6)
      //             ),
      //             child: Container(
      //               alignment: Alignment.center,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Padding(
      //                     padding: const EdgeInsets.all(5.0),
      //                     child: Text(
      //                       'Book Hall',
      //                       style: TextStyle(
      //                         fontSize: 19,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                   Icon(
      //                     Icons.arrow_forward,
      //                     color: Colors.white,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           SizedBox(height:30),
      //           ElevatedButton(
      //             onPressed: (){Navigator.of(context).pushReplacementNamed(
      //                 CalendarWidget.routeName);},
      //             style: ElevatedButton.styleFrom(
      //                 primary: Color.fromRGBO(255, 76, 41,0.8),
      //                 padding: EdgeInsets.all(6)
      //             ),
      //             child: Container(
      //               alignment: Alignment.center,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Padding(
      //                     padding: const EdgeInsets.all(5.0),
      //                     child: Text(
      //                       'Calendar',
      //                       style: TextStyle(
      //                         fontSize: 19,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                   Icon(
      //                     Icons.arrow_forward,
      //                     color: Colors.white,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           SizedBox(height:30),
      //           ElevatedButton(
      //             onPressed: (){Navigator.of(context).pushReplacementNamed(
      //                 StaticDropDown.routeName);},
      //             style: ElevatedButton.styleFrom(
      //                 primary: Color.fromRGBO(255, 76, 41,0.8),
      //                 padding: EdgeInsets.all(6)
      //             ),
      //             child: Container(
      //               alignment: Alignment.center,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Padding(
      //                     padding: const EdgeInsets.all(5.0),
      //                     child: Text(
      //                       'Map',
      //                       style: TextStyle(
      //                         fontSize: 19,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                   Icon(
      //                     Icons.arrow_forward,
      //                     color: Colors.white,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           SizedBox(height:30),
      //           ElevatedButton(
      //             onPressed: (){signOut();},
      //             style: ElevatedButton.styleFrom(
      //                 primary: Color.fromRGBO(255, 76, 41,0.8),
      //                 padding: EdgeInsets.all(6)
      //             ),
      //             child: Container(
      //               alignment: Alignment.center,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Padding(
      //                     padding: const EdgeInsets.all(5.0),
      //                     child: Text(
      //                       'Log Out',
      //                       style: TextStyle(
      //                         fontSize: 19,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                   Icon(
      //                     Icons.arrow_forward,
      //                     color: Colors.white,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //
      //         ],
      //       ),
      //     ),
      //   ),
      //
      // ),

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(
                    'Home',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,
              fontSize: 25,fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap:  ()async{
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
                    child:  Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('asset/booking2.jpg',height: 100,),
                          ),
                          Text('Book Hall',style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(StaticDropDown.routeName);
                    },
                    child:  Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Image.asset('asset/map.jpg',height: 120,),
                          Text('Map',style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(CalendarWidget.routeName);
                      Navigator.of(context).pushReplacementNamed(CalendarWidget.routeName);
                    },
                    child:  Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('asset/calendar.jpg',width: 120,),
                          ),
                          Text('Calendar',style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),
                  ),
                ), SizedBox(width: 5,),
                Card(

                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      signOut();
                    },
                    child:  Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Image.asset('asset/logout2.jpg',height: 100,),
                          SizedBox(height: 10,),
                          Text('Log Out',style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

  void signOut() async {
    await _auth.signOut().then((result) {
      Navigator.of(context)
          .pushAndRemoveUntil(
        CupertinoPageRoute(
            builder: (context) => LoginScreen()
        ),
            (_) => false,
      );
    });
  }
}