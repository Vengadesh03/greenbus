import 'dart:async';
import 'dart:convert';

import 'package:bloodbank/ui/screens/bottomnavigator.dart';
import 'package:bloodbank/ui/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
      final _formKey = GlobalKey<FormState>();

   TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _userEmail;
  GlobalKey<ScaffoldState> _signUpKey = GlobalKey<ScaffoldState>();
   Future _signInWithEmailAndPassword({String email, String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User user;
    _userEmail = "";
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      print("inside $user");
      _userEmail = user.email;
    } catch (e) {
      return {"result": "${e.message}"};
    }
    return _userEmail != ""
        ? {
            "result": "LOGIN SUCCESS",
            "uid": user.uid,
            "name": user.displayName,
            "email": user.email,
            "phone": user.phoneNumber,
            "photo": user.photoURL
          }
        : {"result": "LOGIN FAILURE"};
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _signUpKey,
      body: Container(
        child: Form(
          key: _formKey,
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text("LOGIN",
                        style: TextStyle(
                          fontSize: 30,
                        ))),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: TextFormField(
                    validator: (e) {
                        var email = _emailController.text;
                        bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(email);
                        // print(emailValid);
                        if (!emailValid) return 'provide a valid email';
                      },
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: TextFormField(
                      validator: (e) {
                        if (e.length < 8) return 'Provide a valid password';
                      },
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  decoration: BoxDecoration(
                      color: Colors.green[500],
                      // Color.fromARGB(214, 214, 214, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () async{

                        if (_formKey.currentState.validate()) {
                            print(_emailController.text +
                                "    " +
                                _passwordController.text);
                            Map<String, dynamic> result =
                                await _signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                            SnackBar snackBar = SnackBar(
                              content: Text(result['result']),
                              duration: Duration(seconds: 1),
                            );
                            _signUpKey.currentState.showSnackBar(snackBar);

                            if (result['result'] == "LOGIN SUCCESS") {
                              final CollectionReference postsRef =
                                  FirebaseFirestore.instance.collection('users');

                              Map<String, dynamic> loggedInUser = {
                                "name": result['name'] == null
                                    ? _emailController.text.split("@")[0]
                                    : result['name'],
                                "email": result['email']
                              };

                              await postsRef.doc(result['uid']).set(loggedInUser);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('userId', result['uid']);
                              Map<String, dynamic> userDetails = {
                                "phone": result['phone'],
                                "name": result['name'],
                                "photo": result['photo'],
                                "email": result['email']
                              };
                              print("user $userDetails");

                              prefs.setBool('isLoggedIn', true);
                              prefs.setString('userDetails',
                                  jsonEncode(userDetails).toString());

                              Timer(Duration(seconds: 1), () async {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BottomNavigator();
                                }));
                              });
                            }
                        }
                          },
                     
                    
                    child: Center(
                        child: Text("Login",
                            style: TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 200),
                  child: Text("Forgot Password?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                Container(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(fontSize: 14, color: Color(0xffBABABA)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Signup()));
                        },
                        child: Text(
                          "Sign up here.",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[500]),
                        )),
                  ],
                ))
              ]),
        ),
      ),
    );
  }
}
