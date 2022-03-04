import 'package:bloodbank/Screens/Homepage.dart';
import 'package:bloodbank/Screens/dashboard.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {


  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

   int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Homepage(),
    // ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: kGoodLightGray,
            ),
            title: Text('HOME'),
            activeIcon: Icon(
              Icons.home,
              // color: kGoodPurple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person
              // color: kGoodLightGray,
            ),
            title: Text('PROFILE'),
            activeIcon: Icon(
              Icons.person,
              // color: kGoodPurple,
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