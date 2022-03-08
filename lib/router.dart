import 'package:bloodbank/Mobilescreeen.dart';
import 'package:bloodbank/ui/screens/Login.dart';
import 'package:bloodbank/ui/screens/all_buses.dart';
import 'package:bloodbank/ui/screens/bottomnavigator.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/mobile':
        return MaterialPageRoute(builder: (_) => MobileScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/':
        return MaterialPageRoute(builder: (_) => BottomNavigator());
      case '/buses':
        return MaterialPageRoute(builder: (_) => AllBuses());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
