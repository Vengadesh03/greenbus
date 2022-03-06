import 'package:bloodbank/ui/screens/bottomnavigator.dart';
import 'package:bloodbank/ui/screens/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.green[500],
                    // Color.fromARGB(214, 214, 214, 1),
                    borderRadius: BorderRadius.circular(30)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigator()));
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
    );
  }
}
