import 'package:bloodbank/constants.dart';
import 'package:bloodbank/ui/screens/Homepage.dart';
import 'package:bloodbank/ui/screens/help.dart';
import 'package:bloodbank/ui/screens/my_bookings.dart';
import 'package:bloodbank/ui/screens/profile.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    MyBookingsScreen(), HelpScreen(), ProfileScreen()
    // ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Home',
              style: regularStyle(
                fontSize: 16.5,
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_online_sharp,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Bookings',
              style: regularStyle(
                fontSize: 16.5,
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.live_help_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Help',
              style: regularStyle(
                fontSize: 16.5,
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Profile',
              style: regularStyle(
                fontSize: 16.5,
                color: Colors.black,
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
