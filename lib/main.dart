import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
   home:Home(),
 ));
}
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
      body:
      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height:60),
          Text('Welcome to WCE Guide !',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,
            fontSize: 25,fontWeight: FontWeight.bold,
          ),),
        Container(
      child: Image.asset('asset/logo2.png',height: 250,width: 250,),
  ),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child:TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.assignment_ind_rounded,
                      color: Color.fromRGBO(255, 76, 41,0.8),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Enter your PRN ',
                    labelStyle:TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
            ),
        Container(
                padding: EdgeInsets.fromLTRB(30.0, 0.0,30.0, 0.0),
                child:TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.remove_red_eye,
                        color: Color.fromRGBO(255, 76, 41,0.8),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Enter your Password ',
                      labelStyle:TextStyle(
                        color: Colors.white,
                      )
                  ),
                ),
              ),
            SizedBox(height: 20,),
            Container(
              margin:EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: ElevatedButton(   onPressed: () {},
                      style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 76, 41,0.8),
                        padding: EdgeInsets.all(15)
                      ),
                        child: Text('Login'),
                      ),
            ),
            SizedBox(height: 10,),
            TextButton(   onPressed: () {},
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15)
              ),
              child: Text('Forgot password',style: TextStyle(
                color: Colors.white,
              ),),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text('Don\u0027t have an account ?',textAlign:TextAlign.center,style: TextStyle(
    color: Colors.white,
    ),),
    TextButton(   onPressed: () {},
    style: TextButton.styleFrom(
    padding: EdgeInsets.all(15)
    ),
    child: Text('Sign up',style: TextStyle(
    color: Colors.white,
      decoration: TextDecoration.underline,
      decorationThickness: 3,
    ),),
    ),
        ],
    ),
      ],),
    );
  }
}


