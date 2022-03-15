import 'package:bloodbank/core/services/api.dart';
import 'package:bloodbank/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  Api _api = locator<Api>();
  String selectedSource = "";
  String selectedDestination = "";
  DateTime selectedDate = DateTime.now();
  int seatMaxCount = 0;
  String userdocId = "";
  List seatsData = [];
  setSelectedSource(value) {
    selectedSource = value;
    notifyListeners();
  }

  resetSeatMaxCount() {
    seatMaxCount = 0;
    notifyListeners();
  }

  setUserDocId(value) {
    userdocId = value;
    notifyListeners();
  }

  setSeatMaxCount(value) {
    if (value) {
      seatMaxCount++;
    } else {
      seatMaxCount--;
    }
    notifyListeners();
  }

  setSeatsData(value) {
    seatsData = value;
    notifyListeners();
  }

  setParticularSeatData(index, value) {
    print("INDEX $index $value");
    setSeatMaxCount(value);
    seatsData[index]["isSelected"] = value;
    notifyListeners();
  }

  setSelectedDestination(value) {
    selectedDestination = value;
    notifyListeners();
  }

  setSelectedDateTime(value) {
    selectedDate = value;
    notifyListeners();
  }

  Future fetchBannerImages() async {
    List<QueryDocumentSnapshot> banners;
    QuerySnapshot result = await _api.getDataCollection(path: 'covidbanners');
    banners = result.docs.toList();
    return banners[0].data();
  }

  Future queryUser({String email}) async {
    List recents = [];
    var result = await _api.queryUser(email: email);
    recents = result.docs.map((e) {
      Map a = e.data();
      a["id"] = e.id;
      return a;
    }).toList();
    return recents;
  }

  Future getRecents({docId}) async {
    List recents = [];
    var result = await _api.getRecentHistory(docId: docId);
    recents = result.docs.map((e) {
      Map a = e.data();
      a["id"] = e.id;
      return a;
    }).toList();

    return recents;
  }

  Future getMyBookings({docId}) async {
    List recents = [];
    var result = await _api.getMyBookings(docId: userdocId);
    recents = result.docs.map((e) {
      Map a = e.data();
      a["id"] = e.id;
      return a;
    }).toList();
    return recents;
  }

  Future addBookings({
    Map<String, dynamic> data,
    parentDocId,
  }) async {
    var result = await _api.addBookings(data: data, parentDocId: parentDocId);
    print("MY res $result");
    return result != null ? true : false;
  }

  Future addRecents({
    Map<String, dynamic> data,
    parentDocId,
  }) async {
    var result = await _api.addRecents(data: data, parentDocId: parentDocId);
    return result;
  }

  Future updateSeatBooked({docId, parentDocId}) async {
    List alteredData = seatsData;
    alteredData.forEach((element) {
      if (element["isSelected"]) {
        element["hasBooked"] = true;
      }
      element.removeWhere((key, value) => key == "isSelected");
    });
    await _api.updateBookedSeat(
        docId: parentDocId, date: docId, data: {"seats": alteredData});
    return true;
  }

  Future cloneDoc({parentDocId}) async {
    await _api.cloneDoc(
      docId: parentDocId,
    );
  }

  Future getAllBusesForSelectedRoute({source, destination}) async {
    List buses;
    var result = await _api.getAllBusesForSelectedRoute(
        source: source, destination: destination);
    buses = result.docs.map((e) {
      Map a = e.data();
      a["id"] = e.id;
      return a;
    }).toList();
    print(buses);
    return buses;
  }

//
  Future getSeatsForSelectedBusDate({docId, parentDocId}) async {
    var result =
        await _api.getSeatsForSelectedBusDate(date: docId, docId: parentDocId);
    if (result != null) {
      result["seats"].forEach((e) {
        e["isSelected"] = false;
      });
      setSeatsData(result["seats"]);
    }
    return result;
  }

  //

  Future seatAvailability({docId, docName}) async {
    bool result = await _api.seatAvailability(docId: docId, docName: docName);
    return result;
  }

  Future fillDataTemp({docId, docName, Map<String, dynamic> data}) async {
    List buses;
    var result = await _api.fillDataTemporarily(
        docId: docId, docName: docName, data: data);
  }

  //

  Future getAvailableLocations() async {
    List locations;
    QuerySnapshot result = await _api.getDataCollection(path: 'locations');
    locations = result.docs.map((e) => e.data()).toList();
    return locations;
  }
}
