import 'package:bloodbank/Screens/dashboard.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   DateTime availableDate = DateTime.now(), enquiryValidity = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.directions_bus,
          color: Colors.green,
        ),
        title: Center(
            child: Text(
          "Journey Details",
          style: TextStyle(color: Colors.black),
        )),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left:30),
                      child: Text("From"),
                    ),
                     SizedBox(height:10),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Boarding",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:150),
                      child: Image.asset("assets/images/drop.png")),
                    // SizedBox(height:5),
                    Container(
                      margin: EdgeInsets.only(left:30),
                      child: Text("To"),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5, left: 30, right: 30, bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Destination",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                      SizedBox(height:20),
                       Padding(
                                padding:
                                    EdgeInsets.only(left: 30.0, right: 30.0),
                                child: Container(
                                  width:  MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  padding: EdgeInsets.only(
                                      top: 6.0,
                                      bottom: 6.0,
                                      left: 12.0,
                                      right: 8.0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.green),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Stack(children: [
                                    GestureDetector(
                                        onTap: () async {
                                          final DateTime selected =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: availableDate,
                                            firstDate: DateTime(1970),
                                            lastDate: DateTime(3025),
                                          );
                                          if (selected != null) {
                                            setState(() {
                                              availableDate = selected;
                                            });
                                          }
                                        },
                                        child: Icon(Icons.calendar_today)
                                        
                                        // Image.asset(
                                        //     "assets/images/drop.png")
                                            ),
                                    Positioned(
                                        left: 120.0,
                                        top: 15.0,
                                        child: Center(
                                          child: Text(
                                              "${availableDate.day}/${availableDate.month}/${availableDate.year}"),
                                        ))
                                  ]),
                                ),
                              ),
                              SizedBox(height:20),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                                  },
                                                                  child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.greenAccent[700],
                    // Color.fromARGB(214, 214, 214, 1),
                    // borderRadius: BorderRadius.circular(30)
                    ),
                child: Center(
                    child: Text("SEARCH BUS",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              ),
                                ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
