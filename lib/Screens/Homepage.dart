import 'package:bloodbank/Screens/dashboard.dart';
import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:bloodbank/screens/available_locations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime availableDate = DateTime.now(), enquiryValidity = DateTime.now();
  TextEditingController boardingController;
  TextEditingController destinationController;
  GeneralProvider generalProvider;
  @override
  void initState() {
    // TODO: implement initState
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    super.initState();
    boardingController = TextEditingController();
    destinationController = TextEditingController();
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
    super.didChangeDependencies();
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
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From"),
                      SizedBox(height: 10),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              print(generalProvider.selectedSource);
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
                                          fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                                print(images[index]['image']);
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
