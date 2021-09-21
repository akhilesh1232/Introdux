import 'package:flutter/material.dart';
import 'package:mini_project2/screens/home_screen.dart';
import 'package:mini_project2/screens/login_screen.dart';
import 'package:mini_project2/screens/signup_screen.dart';
import 'package:mini_project2/screens/forgot_password_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home:LoginScreen(),
      routes: {
        SignupScreen.routeName: (ctx)=> SignupScreen(),
        LoginScreen.routeName: (ctx)=> LoginScreen(),
        HomeScreen.routeName: (ctx)=> HomeScreen(),
        ForgotPasswordScreen.routeName: (ctx)=>ForgotPasswordScreen(),
      },
    );
  }
}