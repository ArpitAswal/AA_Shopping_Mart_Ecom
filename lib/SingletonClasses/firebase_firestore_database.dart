
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseService {
  // Singleton instance
  static final FirestoreDatabaseService _instance =
  FirestoreDatabaseService._internal();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Private constructor
  FirestoreDatabaseService._internal();

  // Factory constructor
  factory FirestoreDatabaseService() {
    return _instance;
  }

  // Get collection reference
  CollectionReference getCollection(String collection) {
    return _firestore.collection(collection);
  }

  // CRUD Operations
  Future<void> createDocument(String collection, String doc, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(doc).set(data);
  }

  Future<DocumentSnapshot> readDocument(String collection, String docId) async {
    return await _firestore.collection(collection).doc(docId).get();
  }

  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  Future<void> deleteDocument(String collection, String docId) async {
    await _firestore.collection(collection).doc(docId).delete();
  }
}
