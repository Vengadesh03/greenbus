import 'package:bloodbank/constants.dart';
import 'package:flutter/material.dart';

class BusDetails extends StatefulWidget {
  final Map busDetails;
  BusDetails({this.busDetails});
  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size / 9,
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left_outlined,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/bus.png',
                            height: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.busDetails['travelsName'],
                            style: boldStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.5,
                                color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.busDetails['filterType'] == "AC"
                                ? "A/C" +
                                    " Sleeper " +
                                    "(${widget.busDetails['sleeperConfig']})"
                                : "Non A/C Seater / Sleeper (${widget.busDetails['sleeperConfig']})",
                            style: regularStyle(
                                fontSize: 17.5, color: Colors.black),
                          )
                        ],
                      )
                    ]),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 25,
                        width: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.busDetails['rating'],
                              style: regularStyle(
                                  fontSize: 15.5, color: Colors.white),
                            )
                          ],
                        ),
                        decoration:
                            BoxDecoration(color: AppConstants.primaryColor),
                      ),
                      Container(
                        height: 25,
                        width: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.black,
                              size: 16,
                            ),
                            Text(
                              widget.busDetails['totalPeople'],
                              style: regularStyle(
                                  fontSize: 12.5, color: Colors.black),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.grey[300]),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
      body: Container(
        height: screenSize.height,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Seat(),
            )
          ],
        ),
      ),
      floatingActionButton: RaisedButton(
        color: AppConstants.primaryAccent,
        textColor: Colors.white,
        child: Text('Bus Details'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Seat extends StatefulWidget {
  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  infoTile({Color color, String text}) {
    return Column(
      children: [
        Image.asset("assets/images/seat.png", color: color),
        Text(text)
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            infoTile(text: "Sleeper", color: AppConstants.primaryColor),
            infoTile(text: "Booked Seat", color: AppConstants.greyColor)
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String config = "2+2";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
              icon: Icon(
                Icons.info,
                size: 28,
              ),
              onPressed: () {
                showAlertDialog(context);
              }),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/steering.png',
              height: 80,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        config == "2+2"
            ? Container(
                child: Column(
                children: List.generate(
                  5,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              renderSeat(isBooked: true),
                              renderSeat(),
                            ]),
                            Row(children: [
                              renderSeat(),
                              renderSeat(),
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
            : Container(
                child: Image.asset("assets/images/seat.png",
                    color: Colors.grey[600]),
              ),
      ],
    );
  }

  Widget renderSeat({bool isBooked = false}) {
    return Container(
      padding: EdgeInsets.only(right: 15),
      child: Image.asset(
        "assets/images/seat.png",
        color: isBooked ? Colors.grey[700] : AppConstants.primaryColor,
      ),
    );
  }
}

class MoreBusDetails extends StatefulWidget {
  @override
  State<MoreBusDetails> createState() => _MoreBusDetailsState();
}

class _MoreBusDetailsState extends State<MoreBusDetails> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: double.infinity,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
