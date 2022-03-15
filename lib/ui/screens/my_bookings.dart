import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:bloodbank/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  GeneralProvider generalProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "My Bookings",
          style: regularStyle(color: Colors.black),
        ),
      ),
      body: Container(
          child: FutureBuilder(
        future: generalProvider.getMyBookings(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 20,
                  shadowColor: AppConstants.primaryColor,
                  child: Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "BOARDING : " + snapshot.data[index]["source"],
                          style:
                              regularStyle(fontSize: 16.5, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Icon(Icons.arrow_downward,
                              color: AppConstants.primaryAccent),
                        ),
                        Text(
                          "DESTINATION : " +
                              snapshot.data[index]["destination"],
                          style:
                              regularStyle(fontSize: 16.5, color: Colors.black),
                        ),
                        Text(
                          "DATE : " + snapshot.data[index]["date"],
                          style: boldStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "AMOUNT : " + snapshot.data[index]["amount"],
                          style: boldStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(12)),
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    width: 200,
                  ),
                );
              },
            );
          }
          return Loader();
        },
      )),
    );
  }
}
