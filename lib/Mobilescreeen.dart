import 'dart:async';

import 'package:bloodbank/splash.dart';
import 'package:bloodbank/ui/screens/Login.dart';
import 'package:bloodbank/ui/screens/bottomnavigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MobileScreen extends StatefulWidget {
  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  var loggedIn;
  Future userDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('isLoggedIn');
  }

  @override
  void initState() {
    super.initState();
    userDetail();
    Timer(
        Duration(seconds: 3),
        () => loggedIn != null || loggedIn == false
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigator()))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}
