import 'package:flutter/material.dart';
import 'package:mini_project2/services/authentication.dart';
import 'package:mini_project2/screens/login_screen.dart';
import 'package:mini_project2/services/authentication.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName='/password';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 final AuthenticationService _auth = AuthenticationService();
  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 50, 0.4),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60,),
                 Icon(
                    Icons.lock_outline,size: 50,color: Colors.white,
                  ),
                  SizedBox(height: 20,),
                  Text('Forgot Password ?',textAlign:TextAlign.left,style: TextStyle(color: Colors.white,
                    fontSize: 30,fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,0,25,0),
                    child: Text('We just need your registered email address to send you password reset link',textAlign:TextAlign.center, style: TextStyle(color: Colors.grey,fontSize: 20),),
                  ),
                  SizedBox(height:30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(labelText: 'Enter your Email',labelStyle:TextStyle(
                        color: Colors.white,
                      ),prefixIcon: Icon(Icons.email_outlined,
                        color: Color.fromRGBO(255, 76, 41,0.8),
                      ), enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(255, 76, 41,0.8),),
                      ),
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
                  ),
                    SizedBox(height: 20,),
                  //password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(   onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendpasswordresetemail();
                        }
                      },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(255, 76, 41,0.8),
                            padding: EdgeInsets.all(15)
                        ),
                        child: Text('Request Reset Link'),
                      ),
                    ),
                  ),
                  SizedBox(height:30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child:TextButton(   onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            LoginScreen.routeName);
                      },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.all(15)
                        ),
                        child: Text('Back to Login',style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationThickness: 3,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
  void sendpasswordresetemail() async{
    dynamic result = await _auth.resetPassword(
        _emailController.text);
  }
}


