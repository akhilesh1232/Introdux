import 'package:flutter/material.dart';
//import 'listSearch.dart';
import 'package:myapp/dropdownlist.dart';
//import 'package:myapp/map.dart';

void main() {
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
    return Scaffold(
      body: Dropdownsearch(),
    );
  }
}
