import 'package:bloodbank/constants.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  // const Aboutus({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(
title: Text("About Us"),
backgroundColor: AppConstants.primaryColor,
            ),
        body: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ips"),
        
      ),
    );
  }
}