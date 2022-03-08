import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset("assets/images/bus.gif",),
          
       
            Text(
              "Green Bus",
              style: textStyle(
                  fontSize: 18.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ])),
    );
  }

  textStyle({double fontSize, Color color, FontWeight fontWeight}) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
