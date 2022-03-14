import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:bloodbank/ui/screens/bus_details.dart';
import 'package:bloodbank/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllBuses extends StatefulWidget {
  @override
  State<AllBuses> createState() => _AllBusesState();
}

class _AllBusesState extends State<AllBuses> {
  GeneralProvider generalProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  }

  Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          generalProvider.selectedSource +
              " - " +
              generalProvider.selectedDestination,
          style: regularStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Container(
          height: screenSize.height,
          width: double.infinity,
          child: FutureBuilder(
            future: generalProvider.getAllBusesForSelectedRoute(
                source: generalProvider.selectedSource,
                destination: generalProvider.selectedDestination),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text("No buses found for this route",
                        style:
                            regularStyle(fontSize: 16.5, color: Colors.black)),
                  );
                }
                return ListView.separated(
                    itemBuilder: (context, index) {
                      Map item = snapshot.data[index];
                      return InkWell(
                        onTap: () async {
                          String docName =
                              DateFormat.yMMMd().format(DateTime.now());
                          bool alreadyAvailable =
                              await generalProvider.seatAvailability(
                                  docId: snapshot.data[index]["id"],
                                  docName: docName);
                          if (!alreadyAvailable) {
                            Map<String, dynamic> data = {
                              'date': docName,
                              'seats': []
                            };
                            for (int i = 1; i <= 20; i++) {
                              data['seats'].add({
                                'seat': i.toString(),
                                'price': '950',
                                'hasBooked': false
                              });
                            }
                            print(data);
                            generalProvider.fillDataTemp(
                                docId: snapshot.data[index]["id"],
                                data: data,
                                docName: docName);
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BusDetails(
                                busDetails: item,
                              ),
                            ),
                          );

                          // generalProvider.cloneDoc(
                          //   parentDocId: snapshot.data[index]["id"],
                          // );
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (item['hasOffer'])
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/logo.png',
                                            height: 30,
                                          ),
                                          Text(item['offerPercent'] + "% OFF",
                                              style: regularStyle(
                                                  fontSize: 16.5,
                                                  color: Colors.red)),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(item['startTime'] + "  ",
                                            style: boldStyle(
                                                fontSize: 16.5,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Text(item['endTime'],
                                            style: regularStyle(
                                                fontSize: 16.5,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: "From ",
                                        style: boldStyle(
                                            fontSize: 18.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: "\u{20B9}" +
                                                  item['startingTicketRate'],
                                              style: regularStyle(
                                                  fontSize: 16.5,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ]),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(item['duration'] + "  ",
                                      style: regularStyle(
                                        fontSize: 16.5,
                                        color: Colors.black,
                                      )),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(4)),
                                    height: 8,
                                    width: 8,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                      item['seatsAvailable'].toString() +
                                          "  Seats",
                                      style: regularStyle(
                                        fontSize: 16.5,
                                        color: item['seatsAvailable'] > 5
                                            ? Colors.green
                                            : Colors.orange,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  if (item['stops'].length > 2)
                                    Text(item['stops'][0] +
                                        " | " +
                                        item['stops'][1] +
                                        " + " +
                                        "${item['stops'].length - 2} stops")
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              item['travelsName'],
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
                                              item['filterType'] == "AC"
                                                  ? "A/C" +
                                                      " Sleeper " +
                                                      "(${item['sleeperConfig']})"
                                                  : "Non A/C Seater / Sleeper (${item['sleeperConfig']})",
                                              style: regularStyle(
                                                  fontSize: 17.5,
                                                  color: Colors.black),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
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
                                                item['rating'],
                                                style: regularStyle(
                                                    fontSize: 15.5,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: AppConstants.primaryColor),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 60,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.people,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              Text(
                                                item['totalPeople'],
                                                style: regularStyle(
                                                    fontSize: 12.5,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]),
                                        )
                                      ],
                                    )
                                  ]),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 5,
                        thickness: 1,
                      );
                    },
                    itemCount: snapshot.data.length);
              }
              return Loader();
            },
          )),
    );
  }
}
