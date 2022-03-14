import 'dart:convert';

import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/payment.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:bloodbank/ui/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'available_locations.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime availableDate = DateTime.now(), enquiryValidity = DateTime.now();
  TextEditingController boardingController;
  TextEditingController destinationController;
  TextEditingController dateController;

  GeneralProvider generalProvider;
  fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userDetails = jsonDecode(prefs.getString('userDetails'));
    return userDetails;
  }

  getRecents() async {
    var userDetails = await fetchUserDetails();
    if (userDetails != null) {
      String email = userDetails['email'].toString();
      List doc = await generalProvider.queryUser(email: email);
      // print("DOC $doc");
      if (doc != null || doc.isNotEmpty) {
        var a = await generalProvider.getRecents(docId: doc[0]["id"]);
        return a;
      }
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    super.initState();
    boardingController = TextEditingController();
    destinationController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    boardingController.text = Provider.of<GeneralProvider>(
      context,
      listen: true, // Be sure to listen
    ).selectedSource;
    destinationController.text = Provider.of<GeneralProvider>(
      context,
      listen: true, // Be sure to listen
    ).selectedDestination;
    dateController.text =
        DateFormat.yMMMEd().format(Provider.of<GeneralProvider>(
      context,
      listen: true, // Be sure to listen
    ).selectedDate);
    super.didChangeDependencies();
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2040))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      // print(pickedDate);
      generalProvider.setSelectedDateTime(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    boardingController.text = generalProvider.selectedSource;
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
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From"),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: TextField(
                            readOnly: true,
                            controller: boardingController,
                            onChanged: generalProvider.setSelectedSource,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AvailableLocations(
                                        setData: (value) {
                                          generalProvider
                                              .setSelectedSource(value);
                                        },
                                      )));
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Boarding",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/drop.png"),
                          ],
                        ),
                        Text("To"),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AvailableLocations(
                                        setData: (value) {
                                          generalProvider
                                              .setSelectedDestination(value);
                                        },
                                      )));
                            },
                            controller: destinationController,
                            decoration: InputDecoration(
                              hintText: "Enter Destination",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Date"),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: TextField(
                            controller: dateController,
                            readOnly: true,
                            onTap: () {
                              _pickDateDialog();
                            },
                            decoration: InputDecoration(
                              hintText: "Select Date",
                              suffixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (generalProvider.selectedSource.isEmpty) {
                                  toaster(message: "Select boarding");
                                } else if (generalProvider
                                    .selectedDestination.isEmpty) {
                                  toaster(message: "Select Destination");
                                } else if (generalProvider.selectedDate ==
                                    null) {
                                  toaster(message: "Select Date");
                                } else {
                                  try {
                                    var userDetails = await fetchUserDetails();
                                    if (userDetails != null) {
                                      String email =
                                          userDetails['email'].toString();
                                      List doc = await generalProvider
                                          .queryUser(email: email);
                                      if (doc != null || doc.isNotEmpty) {
                                        generalProvider.addRecents(
                                            parentDocId: doc[0]["id"],
                                            data: {
                                              "source": boardingController.text,
                                              "destination":
                                                  destinationController.text,
                                              "date": dateController.text
                                            });
                                      }
                                    }
                                  } catch (e) {}
                                  Navigator.pushNamed(context, '/buses');
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryAccent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                    child: Text("Search Bus",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("RECENT SEARCHES"),
                  ],
                ),
                FutureBuilder(
                    future: getRecents(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 140,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 20,
                                    shadowColor: AppConstants.primaryColor,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot.data[index]["source"],
                                            style: regularStyle(
                                                fontSize: 16.5,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, bottom: 2),
                                            child: Icon(Icons.arrow_downward,
                                                color:
                                                    AppConstants.primaryAccent),
                                          ),
                                          Text(
                                            snapshot.data[index]["destination"],
                                            style: regularStyle(
                                                fontSize: 16.5,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            snapshot.data[index]["date"],
                                            style: boldStyle(
                                                fontSize: 14.5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  12)),
                                      margin: EdgeInsets.only(
                                        right: 20,
                                      ),
                                      height: 140,
                                      width: 200,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      }
                      return Container(
                          height: 100,
                          child: Center(
                            child: Text("No Search history"),
                          ));
                    }),
                Row(
                  children: [
                    Text("COVID PANDEMIC AWARENESS"),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                    future: generalProvider.fetchBannerImages(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List images = snapshot.data['images'];
                        return Container(
                          height: 150,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 300,
                                  margin: EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      images[index]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  //     CachedNetworkImage(
                                  //   fit: BoxFit.cover,
                                  //   imageUrl:
                                  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP59-1bbiVX55W1uIdLMtD62PNmYE1oMIKFQ&usqp=CAU",

                                  //   imageBuilder: (context, imageProvider) =>
                                  //       Container(
                                  //     decoration: BoxDecoration(
                                  //       image: DecorationImage(
                                  //           image: imageProvider,
                                  //           fit: BoxFit.cover,
                                  //           colorFilter: ColorFilter.mode(
                                  //               Colors.red, BlendMode.colorBurn)),
                                  //     ),
                                  //   ),
                                  //   placeholder: (context, url) =>
                                  //       CircularProgressIndicator(),
                                  //   // placeholder: (context, url) => Image.asset(
                                  //   //     'assets/images/no_image.png'),
                                  //   // errorWidget: (context, url, error) =>
                                  //   //     Image.asset(
                                  //   //         'assets/images/no_image.png'),
                                  // ),
                                );
                              }),
                        );
                      }
                      return Center(
                        child: Text("Loading..."),
                      );
                    })
              ]),
        ),
      ),
    );
  }
}
