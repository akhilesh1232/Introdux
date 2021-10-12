import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'listSearch.dart';
import 'package:myapp/dropdownlist.dart';
import 'package:myapp/screens/booking_auth.dart';
import 'package:myapp/screens/booking_student.dart';
import 'package:myapp/screens/calendar.dart';
import 'package:myapp/screens/forgot_password_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/signup_screen.dart';
//import 'package:myapp/map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        SignupScreen.routeName: (ctx)=> SignupScreen(),
        LoginScreen.routeName: (ctx)=> LoginScreen(),
        HomeScreen.routeName: (ctx)=> HomeScreen(),
        ForgotPasswordScreen.routeName: (ctx)=>ForgotPasswordScreen(),
        BookingStudentScreen.routeName: (ctx)=>BookingStudentScreen(),
        BookingAuthScreen.routeName: (ctx)=>BookingAuthScreen(value: '',),
        CalendarWidget.routeName:(ctx)=>CalendarWidget(),
        Dropdownsearch.routeName:(ctx)=>Dropdownsearch(),
      },
    );
  }
}
