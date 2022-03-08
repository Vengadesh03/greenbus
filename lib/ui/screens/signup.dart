import 'dart:async';
import 'package:bloodbank/ui/screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
    final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _userEmail;
  GlobalKey<ScaffoldState> _signUpKey = GlobalKey<ScaffoldState>();
  Future _register({String email, String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _userEmail = "";
    // final User user = (await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // ))
    //     .user;
    // _userEmail = user.email;
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      print(user.uid);
      _userEmail = user.email;
    } catch (e) {
      return e.message;
    }
    // return _userEmail == ""
    //     ? "Authentication Failed..Try Again"
    //     : "Verfication Success";
    return _userEmail != ""
        ? "Account Created Successfully"
        : "Something went wrong.Try Again";
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
                    child: Text("SIGNUP",
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
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Confirm password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                     if (_formKey.currentState.validate()) {
                    print(_emailController.text);
                    print(_passwordController.text);
                    String result = await _register(
                        email: _emailController.text,
                        password: _passwordController.text);
                    print(result);
                    SnackBar snackBar = SnackBar(
                      content: Text(result),
                      duration: Duration(seconds: 1),
                    );
                    _signUpKey.currentState.showSnackBar(snackBar);
                    if (result == "Account Created Successfully") {
                      Timer(Duration(seconds: 1), () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      });
                    }
                     }
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    decoration: BoxDecoration(
                        color: Colors.green[500],
                        // Color.fromARGB(214, 214, 214, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text("Register",
                            style: TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account? ",
                      style: TextStyle(fontSize: 14, color: Color(0xffBABABA)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Login.",
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
