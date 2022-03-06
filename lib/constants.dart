import 'package:flutter/material.dart';

class AppConstants {
  static Color primaryAccent = Colors.greenAccent[700];
  static const Color primaryColor = Colors.green;
  static Color greyColor = Colors.grey[700];
}

TextStyle regularStyle({double fontSize, FontWeight fontWeight, Color color}) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}

TextStyle boldStyle({double fontSize, FontWeight fontWeight, Color color}) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}

enum SeatStatus { MaleSeat, FemaleSeat }
