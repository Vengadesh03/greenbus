import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference ref;

  Future<QuerySnapshot> getDataCollection({String path}) {
    ref = _db.collection(path);
    return ref.get();
  }

  Future<QuerySnapshot> getAllBusesForSelectedRoute(
      {String source, String destination}) {
    Query query = _db
        .collection('travels')
        .where('source', isEqualTo: source)
        .where('destination', isEqualTo: destination);
    return query.get();
  }

  Future<QuerySnapshot> fillDataTemporarily(
      {var docId, String docName, Map<String, dynamic> data}) async {
    await _db
        .collection('travels')
        .doc(docId)
        .collection('dates')
        .doc(docName)
        .set(data);
  }

  Future seatAvailability({var docId, String docName}) async {
    var existingSeatAvail = await _db
        .collection('travels')
        .doc(docId)
        .collection('dates')
        .doc(docName)
        .get();
    return existingSeatAvail.exists;
  }

  Future<QuerySnapshot> queryUser({email}) async {
    Query query = _db.collection('users').where('email', isEqualTo: email);
    return query.get();
  }

  Future getRecentHistory({docId}) async {
    var result = await _db
        .collection('users')
        .doc(docId)
        .collection('recentsearches')
        .orderBy('date', descending: true)
        .get();
    return result;
  }

  Future addRecents({
    Map<String, dynamic> data,
    parentDocId,
  }) async {
    // print("DOC ID $parentDocId data $data");
    var result = await _db
        .collection('users')
        .doc(parentDocId)
        .collection('recentsearches')
        .add(data);
    return result;
  }

  Future cloneDoc({var docId}) async {
    var result = await _db.collection('travels').doc(docId).get();
    await _db.collection('travels').add(result.data());
    // .collection('dates')
    // .doc(docName)
    // .get();
  }

  Future getSeatsForSelectedBusDate({var docId, String date}) async {
    DocumentSnapshot result = await _db
        .collection('travels')
        .doc(docId)
        .collection('dates')
        .doc(date)
        .get();
    print("REES ${result.data()}");
    return result.data();
  }

  Future updateBookedSeat({var docId, String date, var data}) async {
    _db
        .collection('travels')
        .doc(docId)
        .collection('dates')
        .doc(date)
        .update(data)
        .then((value) {
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
