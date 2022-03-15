import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/payment.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:bloodbank/ui/widgets/loader.dart';
import 'package:bloodbank/ui/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusDetails extends StatefulWidget {
  final Map busDetails;
  BusDetails({this.busDetails});
  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    // print("fdhjbdjhf");
    // print(widget.busDetails);
  }

  Size screenSize;
  GeneralProvider generalProvider;
  Widget busWidget;
  @override
  Widget build(BuildContext context) {
    busWidget = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                  style: regularStyle(fontSize: 17.5, color: Colors.black),
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
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
                    style: regularStyle(fontSize: 15.5, color: Colors.white),
                  )
                ],
              ),
              decoration: BoxDecoration(color: AppConstants.primaryColor),
            ),
            Container(
              height: 25,
              width: 60,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    widget.busDetails['totalPeople'],
                    style: regularStyle(fontSize: 12.5, color: Colors.black),
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.grey[300]),
            )
          ],
        )
      ]),
    );

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
            title: busWidget),
      ),
      body: Container(
        height: screenSize.height,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Seat(
                        parentDocId: widget.busDetails["id"],
                        date: DateFormat.yMMMd().format(DateTime.now()),
                      )
                    ],
                  ),
                )
                // Seat(),
                )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RaisedButton(
              color: AppConstants.primaryAccent,
              textColor: Colors.white,
              child: Text('Book'),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Payment(
                          docId: widget.busDetails["id"],
                          travelsName: widget.busDetails['travelsName'],
                          busWidget: busWidget,
                        )));
              }),
          SizedBox(
            width: 10,
          ),
          RaisedButton(
            color: AppConstants.primaryAccent,
            textColor: Colors.white,
            child: Text('Bus Details'),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 100,
                          ),
                          Text(
                            "Amenities & photos",
                            style: regularStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Image.asset("assets/images/bus.png"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Track My Bus",
                            style: regularStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            height: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.busDetails['busImages'].length,
                              itemBuilder: (context, index) {
                                var image = widget.busDetails['busImages'];

                                return Container(
                                  height: 80,
                                  margin: EdgeInsets.only(right: 16),
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        image[index],
                                        fit: BoxFit.cover,
                                      )),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            height: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ratings  & Reviews",
                            style: regularStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 25,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.busDetails['rating'],
                                style: boldStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "(${widget.busDetails['totalPeople']} ratings)",
                                style: regularStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            height: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (widget.busDetails['hasChildPolicy'])
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/child.png',
                                        height: 70,
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Child passenger policy",
                                                style: boldStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Children above the age of 5 will need a ticket",
                                                style: regularStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          if (widget.busDetails['hasLuggagePolicy'])
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/luggages.png',
                                        height: 70,
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "luggage policy",
                                                style: boldStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "2 pieces of luggage will be accepted free of charge per" +
                                                    "passenger. Excess items will be chargeable \n\n" +
                                                    "Excess baggage over 10 kgs per passenger will be chargeable",
                                                style: regularStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class Seat extends StatefulWidget {
  final parentDocId;
  final date;
  Seat({this.parentDocId, this.date});
  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  infoTile({Color color, String text}) {
    return Column(
      children: [
        Image.asset("assets/images/seat.png", color: color),
        SizedBox(
          height: 5,
        ),
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
  GeneralProvider generalProvider;

  @override
  void initState() {
    super.initState();
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    generalProvider.resetSeatMaxCount();
  }

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
            InkWell(
              onTap: () {
                print(generalProvider.seatsData);
              },
              child: Image.asset(
                'assets/images/steering.png',
                height: 80,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        config == "2+2"
            ? FutureBuilder(
                future: generalProvider.getSeatsForSelectedBusDate(
                    parentDocId: widget.parentDocId, docId: widget.date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        height: 350,
                        width: double.infinity,
                        child: GridView.count(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          children: List.generate(
                            Provider.of<GeneralProvider>(context)
                                .seatsData
                                .length,
                            (index) {
                              return Container(
                                alignment: Alignment.center,
                                child: RenderSeat(
                                    onTap: () {
                                      if (generalProvider.seatMaxCount < 6) {
                                        generalProvider.setParticularSeatData(
                                          index,
                                          !(generalProvider.seatsData[index]
                                              ["isSelected"]),
                                        );
                                      } else {
                                        toaster(message: AppStrings.maxSeats6);
                                      }
                                    },
                                    isSelected: generalProvider.seatsData[index]
                                        ["isSelected"],
                                    isBooked: generalProvider.seatsData[index]
                                        ["hasBooked"],
                                    seatNo: generalProvider.seatsData[index]
                                        ["seat"],
                                    price: generalProvider.seatsData[index]
                                        ["price"]),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            },
                          ),
                        )
                        //  GridView.builder(
                        //   gridDelegate:
                        //       const SliverGridDelegateWithMaxCrossAxisExtent(
                        //           maxCrossAxisExtent: 200,
                        //           childAspectRatio: 3 / 2,
                        //           crossAxisSpacing: 20,
                        //           mainAxisSpacing: 20),
                        //   itemCount: snapshot.data["seats"].length,
                        //   itemBuilder: (BuildContext ctx, index) {
                        //     return Container(
                        //       alignment: Alignment.center,
                        //       child: Text(snapshot.data["seats"][index]["seat"]),
                        //       decoration: BoxDecoration(
                        //           color: Colors.amber,
                        //           borderRadius: BorderRadius.circular(15)),
                        //     );
                        //   },
                        // ),
                        );
                  }
                  return Loader();
                },
              )

            //   Column(
            //   children: List.generate(
            //     5,
            //     (index) => Container(
            //       margin: EdgeInsets.only(bottom: 18),
            //       child: Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(children: [
            //                 renderSeat(),
            //                 renderSeat(),
            //               ]),
            //               Row(children: [
            //                 renderSeat(),
            //                 renderSeat(),
            //               ])
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ))

            : Container(
                child: Image.asset("assets/images/seat.png",
                    color: Colors.grey[600]),
              ),
      ],
    );
  }
}

class RenderSeat extends StatelessWidget {
  const RenderSeat(
      {Key key,
      @required this.isBooked,
      @required this.seatNo,
      @required this.price,
      this.onTap,
      this.isSelected})
      : super(key: key);

  final bool isBooked;
  final String seatNo;
  final Function onTap;
  final bool isSelected;
  final String price;

  // GeneralProvider generalProvider;
  @override
  Widget build(BuildContext context) {
    // generalProvider = Provider.of<GeneralProvider>(context);
    return InkWell(
      onTap: onTap != null && isBooked != true
          ? onTap
          : () {
              // generalProvider.seatsData
            },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 15),
            child: Column(children: [
              Image.asset(
                "assets/images/seat.png",
                color: isBooked ? Colors.grey[700] : AppConstants.primaryColor,
              ),
              Text(
                seatNo,
                style: regularStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                "\u{20B9} " + price,
                style: regularStyle(fontSize: 16, color: Colors.black),
              )
            ]),
          ),
          if (isSelected == true)
            Positioned(
              top: 0,
              right: -10,
              child: Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              ),
            )
        ],
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

// import 'package:bloodbank/constants.dart';
// import 'package:flutter/material.dart';

// class BusDetails extends StatefulWidget {
//   final Map busDetails;
//   BusDetails({this.busDetails});
//   @override
//   State<BusDetails> createState() => _BusDetailsState();
// }

// class _BusDetailsState extends State<BusDetails> {
//   Size screenSize;
//   @override
//   Widget build(BuildContext context) {
//     screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: MediaQuery.of(context).size / 9,
//         child: AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(
//               Icons.keyboard_arrow_left_outlined,
//               color: Colors.black,
//               size: 28,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: Column(children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/bus.png',
//                             height: 25,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             widget.busDetails['travelsName'],
//                             style: boldStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18.5,
//                                 color: Colors.black),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             widget.busDetails['filterType'] == "AC"
//                                 ? "A/C" +
//                                     " Sleeper " +
//                                     "(${widget.busDetails['sleeperConfig']})"
//                                 : "Non A/C Seater / Sleeper (${widget.busDetails['sleeperConfig']})",
//                             style: regularStyle(
//                                 fontSize: 17.5, color: Colors.black),
//                           )
//                         ],
//                       )
//                     ]),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         height: 25,
//                         width: 60,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                             SizedBox(
//                               width: 3,
//                             ),
//                             Text(
//                               widget.busDetails['rating'],
//                               style: regularStyle(
//                                   fontSize: 15.5, color: Colors.white),
//                             )
//                           ],
//                         ),
//                         decoration:
//                             BoxDecoration(color: AppConstants.primaryColor),
//                       ),
//                       Container(
//                         height: 25,
//                         width: 60,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.people,
//                               color: Colors.black,
//                               size: 16,
//                             ),
//                             Text(
//                               widget.busDetails['totalPeople'],
//                               style: regularStyle(
//                                   fontSize: 12.5, color: Colors.black),
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(color: Colors.grey[300]),
//                       )
//                     ],
//                   )
//                 ]),
//           ),
//         ),
//       ),
//       body: Container(
//         height: screenSize.height,
//         width: double.infinity,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: Seat(),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: RaisedButton(
//         color: AppConstants.primaryAccent,
//         textColor: Colors.white,
//         child: Text('Bus Details'),
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (context) {
//               return SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Seat extends StatefulWidget {
//   @override
//   State<Seat> createState() => _SeatState();
// }

// class _SeatState extends State<Seat> {
//   infoTile({Color color, String text}) {
//     return Column(
//       children: [
//         Image.asset("assets/images/seat.png", color: color),
//         Text(text)
//       ],
//     );
//   }

//   showAlertDialog(BuildContext context) {
//     Widget okButton = TextButton(
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.of(context).pop(false);
//       },
//     );
//     AlertDialog alert = AlertDialog(
//       content: Container(
//         height: 100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             infoTile(text: "Sleeper", color: AppConstants.primaryColor),
//             infoTile(text: "Booked Seat", color: AppConstants.greyColor)
//           ],
//         ),
//       ),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   String config = "2+2";
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           IconButton(
//               icon: Icon(
//                 Icons.info,
//                 size: 28,
//               ),
//               onPressed: () {
//                 showAlertDialog(context);
//               }),
//         ]),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Image.asset(
//               'assets/images/steering.png',
//               height: 80,
//             )
//           ],
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         config == "2+2"
//             ? Container(
//                 child: Column(
//                 children: List.generate(
//                   5,
//                   (index) => Container(
//                     margin: EdgeInsets.only(bottom: 18),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(children: [
//                               renderSeat(isBooked: true),
//                               renderSeat(),
//                             ]),
//                             Row(children: [
//                               renderSeat(),
//                               renderSeat(),
//                             ])
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ))
//             : Container(
//                 child: Image.asset("assets/images/seat.png",
//                     color: Colors.grey[600]),
//               ),
//       ],
//     );
//   }

//   Widget renderSeat({bool isBooked = false}) {
//     return Container(
//       padding: EdgeInsets.only(right: 15),
//       child: Image.asset(
//         "assets/images/seat.png",
//         color: isBooked ? Colors.grey[700] : AppConstants.primaryColor,
//       ),
//     );
//   }
// }

// class MoreBusDetails extends StatefulWidget {
//   @override
//   State<MoreBusDetails> createState() => _MoreBusDetailsState();
// }

// class _MoreBusDetailsState extends State<MoreBusDetails> {
//   Size screenSize;
//   @override
//   Widget build(BuildContext context) {
//     screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         height: screenSize.height,
//         width: double.infinity,
//         child: Column(
//           children: [],
//         ),
//       ),
//     );
//   }
// }
