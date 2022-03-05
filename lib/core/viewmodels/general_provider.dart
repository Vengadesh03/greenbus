import 'package:bloodbank/core/services/api.dart';
import 'package:bloodbank/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  Api _api = locator<Api>();
  String selectedSource = "";
  String selectedDestination = "";

  setSelectedSource(value) {
    selectedSource = value;
    notifyListeners();
  }

  setSelectedDestination(value) {
    selectedDestination = value;
    notifyListeners();
  }

  Future fetchBannerImages() async {
    List<QueryDocumentSnapshot> banners;
    QuerySnapshot result = await _api.getDataCollection(path: 'covidbanners');
    banners = result.docs.toList();
    return banners[0].data();
  }

  Future getAllBusesForSelectedRoute({source, destination}) async {
    List buses;
    var result = await _api.getAllBusesForSelectedRoute(
        source: source, destination: destination);
    buses = result.docs.map((e) => e.data()).toList();
    print(buses);
    return buses;
  }

  Future getAvailableLocations() async {
    List locations;
    QuerySnapshot result = await _api.getDataCollection(path: 'locations');
    locations = result.docs.map((e) => e.data()).toList();
    return locations;
  }
}
