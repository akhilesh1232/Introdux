import 'package:flutter/material.dart';
import 'package:mini_project2/services/authentication.dart';
class HomeScreen extends StatefulWidget {

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'home screen', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            ),
            TextButton(onPressed: () {
              signOut();
            },
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15)
              ),
              child: Text('Log out', style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationThickness: 3,
              ),),
            ),
          ],
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