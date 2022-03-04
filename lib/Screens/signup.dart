import 'package:bloodbank/Screens/Login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text("SIGNUP", style: TextStyle(fontSize: 30,))),
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
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Confirm password",
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
                child: Center(
                    child: Text("Register",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              ),
            
              SizedBox(height:20),
              Container(
               
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                  Text("Have an account? ",style: TextStyle(fontSize: 14,color: Color(0xffBABABA) ),),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text("Login.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green[500] ),)),

                ],)
              )
            ]),
      ),
    );
  }
}
