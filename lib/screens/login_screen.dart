import 'package:flutter/material.dart';
import 'package:myapp/screens/forgot_password_screen.dart';
import 'package:myapp/services/authentication.dart';
import 'package:myapp/screens/forgot_password_screen.dart';
//import 'package:provider/provider.dart';

import 'signup_screen.dart';
import 'home_screen.dart';
//import '../models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
String _emailerror='',_passworderror='';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
      body: Stack(
        children: <Widget>[

          Center(
              child: Container(
                 width: 350,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text('Welcome to WCE Guide !',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,
                          fontSize: 25,fontWeight: FontWeight.bold,
                        ),),
                        Image.asset('asset/logo2.png',height: 250,width: 250,),
                        //email
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                            ), labelText: 'Email', labelStyle:TextStyle(
                            color: Colors.white,
                          ),
                            prefixIcon: Icon(Icons.email_outlined,
                            color: Color.fromRGBO(255, 76, 41,0.8),
                          ),
                            errorText: _emailerror!='' ?_emailerror:null ,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),

                        //password
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelText: 'Password', labelStyle:TextStyle(
                            color: Colors.white,
                          ),
                            prefixIcon: Icon(Icons.remove_red_eye,
                              color: Color.fromRGBO(255, 76, 41,0.8),
                            ),errorText: _passworderror!='' ?_passworderror:null ,
                          ),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(   onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(255, 76, 41,0.8),
                                padding: EdgeInsets.all(15)
                            ),
                            child: Text('Login'),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextButton(   onPressed: () {
                          Navigator.of(context).pushReplacementNamed(ForgotPasswordScreen.routeName);
                        },
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.all(15)
                          ),
                          child: Text('Forgot password',style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Don\u0027t have an account ?',textAlign:TextAlign.center,style: TextStyle(
                              color: Colors.white,
                            ),),
                            TextButton(   onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  SignupScreen.routeName);
                            },
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  void signInUser() async {
    dynamic result = await _auth.loginUser(
        _emailController.text, _passwordController.text);
    if(result!='valid')
      {
        if(result=='Wrong email/password combination.'){
          setState(() {
            _passworderror=result;
          });
        }
        else {
          setState(() {
            _emailerror = result;
          });
        }
      }
    else {
      print('Sign in successful');
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
