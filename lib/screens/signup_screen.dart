import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/services/authentication.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthenticationService _auth=AuthenticationService();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController= new TextEditingController();
  TextEditingController _prnController=new TextEditingController();
  String _textString='',_error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
      body: Stack(
        children: <Widget>[
          
          IconButton(onPressed:(){
    Navigator.push(context,new MaterialPageRoute(builder: (context)=>new LoginScreen()));
          } ,icon:Icon(Icons.arrow_back),color: Colors.white,padding: EdgeInsets.all(40), ),
          Center(
              child: Container(
                width: 350,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text('Create Account',textAlign:TextAlign.left,style: TextStyle(color: Colors.white,
                          fontSize: 30,fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10,),
                        Text('Please Fill the Details below',style: TextStyle(color: Colors.grey,fontSize: 20),),
                        SizedBox(height:30),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(labelText: 'Full name',labelStyle:TextStyle(
                            color: Colors.white,
                          ),hintText: 'Your name',
                            prefixIcon: Icon(Icons.account_circle_rounded,
                            color: Color.fromRGBO(255, 76, 41,0.8),
                          ), enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                          ),),
                          controller: _nameController,
                            validator:(value)
                            {
                              if (value!.trim().isEmpty ) {
                                return 'Please enter your name';
                              }
                            }
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(labelText: 'PRN',labelStyle:TextStyle(
                            color: Colors.white,
                          ),
                            prefixIcon: Icon(Icons.assignment_ind,
                            color: Color.fromRGBO(255, 76, 41,0.8),
                          ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          controller: _prnController,
                          validator:(value)
                            {
                              if (value!.trim().isEmpty || value.length!=14)
                              {
                                return 'Please enter valid PRN';
                              }
                            }
                        ),
                        //email
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(labelText: 'Email',labelStyle:TextStyle(
                            color: Colors.white,
                          ),prefixIcon: Icon(Icons.email_outlined,
                            color: Color.fromRGBO(255, 76, 41,0.8),
                          ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                            ),
                            errorText: _error!='' ?_error:null ,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value)
                          {
                            if (value!.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {},
                        ),
                        //password
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          labelText: 'Password',labelStyle:TextStyle(
                            color: Colors.white,),
                            hintText: 'password should be 8 char long',
                            prefixIcon: Icon(Icons.password_rounded,
                              color: Color.fromRGBO(255, 76, 41,0.8),
                            ),),
                          obscureText: true,
                         controller: _passwordController,
                          validator: (value)
                          {
                            if (value!.trim().isEmpty) {
                              return 'Please enter password';
                            }
                            if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                              return 'Please enter a valid passsword';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            //_authData['password'] = value;
                          },
                        ),

                        //Confirm Password
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(labelText: 'Confirm Password',labelStyle:TextStyle(
                            color: Colors.white,
                          ),prefixIcon: Icon(Icons.password_rounded,
                              color: Color.fromRGBO(255, 76, 41,0.8),
                            ), enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                          ),
                          ),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value!.isEmpty || value!=_passwordController.text)
                            {
                              return 'Please try again';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(   onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createUser();
                            }
                          },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(255, 76, 41,0.8),
                                padding: EdgeInsets.all(15)
                            ),
                            child: Text('Sign Up'),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(_textString,style: TextStyle(color: Colors.grey),textAlign:TextAlign.center,),
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
  void createUser() async {
    dynamic result = await _auth.createNewUser(
        _emailController.text, _passwordController.text, _prnController.text,
        _nameController.text);
    print(result.toString());
    if(result==null)
      {
        setState(() {
          _textString='Verification link has been sent to your email. You can login once the email is verfied\nRedirecting to Login screen..';
        });
        Future.delayed(Duration(seconds: 5),(){
          setState(() {
            Navigator.push(context,new MaterialPageRoute(builder: (context)=>new LoginScreen()));
          });
        });
      }
    else
      setState(() {
        _error='User already exists';
      });

  }
}
