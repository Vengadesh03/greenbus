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
