import 'dart:convert';

import 'package:bloodbank/constants.dart';
import 'package:bloodbank/ui/screens/Login.dart';
import 'package:bloodbank/ui/screens/about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:swiggy_ui/views/screens/favouritesScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Map userDetails;
  fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userDetails = jsonDecode(prefs.getString('userDetails'));
    return userDetails;
  }

  void initState() {
    fetchUserDetails();
    super.initState();
  }

  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(

            key: _key,
            appBar: AppBar(
backgroundColor: AppConstants.primaryAccent,
              title: Text("My Account"),
            ),
            body: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              height: screenSize.height,
              width: screenSize.width,
              child: SingleChildScrollView(
                              child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: fetchUserDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        return Column(children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(75),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.duffyduffylaw.com/wp-content/uploads/2018/05/user-placeholder-200x250.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            userDetails['email'].toString(),
                            style: textStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                            Text(
                          userDetails['name'] ??
                              userDetails['email'].toString().split("@")[0],
                          style: textStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                          
                         
                          SizedBox(
                            height: 15,
                          ),
                        
                          SizedBox(
                            height: 25,
                          ),
                        accountTile("My Booking",(){}),
                      
                  
                                            

                        accountTile("About Us",(){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Aboutus()));
                        }),
                                            

                        accountTile("Settings",(){}),
                                    

                          accountTile("Logout", () async {
                            await FirebaseAuth.instance.signOut();
                            SnackBar snackBar = SnackBar(
                                content: Text("Successfully Logged out"));
                            _key.currentState.showSnackBar(snackBar);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                             
                            prefs.setBool('isLoggedIn', null);
                               prefs.clear();
                            
                            await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login()));
                          }),



                        ]);
                      })
                ]),
              ),
            )));
  }

  textStyle({double fontSize, Color color, FontWeight fontWeight}) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  accountTile(String name, Function onTap) {
    return ListTile(
      onTap: onTap,
      leading: Text(name,
          style: textStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}
