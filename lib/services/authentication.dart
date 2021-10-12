import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/databse/databaseManager.dart';
import 'package:myapp/screens/home_screen.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign up
  Future createNewUser(String email, String password,String PRN,String name) async
  {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      User? usser = FirebaseAuth.instance.currentUser;
      if (usser!= null && !usser.emailVerified) {
        await usser.sendEmailVerification();
      }
        await DatabaseManager(user!.uid).updateUserData(PRN, name);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future loginUser(String email,String password) async
  {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user!.uid);
      return 'valid';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return "Wrong email/password combination.";
          break;
        case "user-not-found":
          return "No user found with this email.";
          break;
        case "user-disabled":
          return "User disabled.";
          break;
        case "invalid-email":
          return "Email address is invalid.";
          break;
        default:
          return "Login failed. Please try again.";
          break;
      }
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
      print('Couldnt sign out');
      print(error.toString());
      return null;
    }
  }
  Future resetPassword(String email) async
  {
    return _auth.sendPasswordResetEmail(email: email);
  }
}
