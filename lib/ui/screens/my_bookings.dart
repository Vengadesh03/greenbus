import 'package:flutter/material.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("MyBookings"),
      ),
    );
  }
}
