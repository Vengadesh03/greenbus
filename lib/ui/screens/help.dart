
import 'package:bloodbank/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  _launchCaller() async {
    const url = "tel:1234567";   
    if (await canLaunch(url)) {
       await launch(url);
    } else {
      throw 'Could not launch $url';
    }   
}
 _textMe() async {
    
      const uri = 'sms:+123456?body=hello';
      await launch(uri);
    
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  _launchCaller();
                },
                              child: Container(
                  height: 30,
                  width: 100,
                  color: AppConstants.primaryColor,
                  child: Center(child: Text("Call")),
                ),
              ),
              InkWell(
                onTap: (){
                  _textMe();
                },
                              child: Container(
                  height: 30,
                  width: 100,
                  color: AppConstants.primaryColor,
                  child: Center(child: Text("Message")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
