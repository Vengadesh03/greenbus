import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableLocations extends StatefulWidget {
  final Function setData;
  AvailableLocations({this.setData});
  @override
  State<AvailableLocations> createState() => _AvailableLocationsState();
}

class _AvailableLocationsState extends State<AvailableLocations> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    final generalProvider = Provider.of<GeneralProvider>(context);

    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: TextField(
            style: regularStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintText: "Enter the name",
                hintStyle: regularStyle(fontSize: 18, color: Colors.white54),
                border: InputBorder.none),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: screenSize.height,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: FutureBuilder(
              future: generalProvider.getAvailableLocations(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 5,
                          thickness: 1,
                        );
                      },
                      itemBuilder: (context, index) {
                        return searchItemTile(
                            name: snapshot.data[index]['name'],
                            onTap: () {
                              widget.setData(snapshot.data[index]['name']);
                              Navigator.pop(context);
                            });
                      });
                }
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppConstants.primaryAccent,
                  ),
                );
              }),
        ));
  }

  Widget searchItemTile({@required String name, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: regularStyle(fontSize: 24, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
