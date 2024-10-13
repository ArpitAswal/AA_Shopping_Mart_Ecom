
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDatabaseService {
  // Singleton instance
  static final FirebaseRealtimeDatabaseService _instance =
  FirebaseRealtimeDatabaseService._internal();

  // Firebase Realtime Database instance
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Private constructor
  FirebaseRealtimeDatabaseService._internal();

  // Factory constructor
  factory FirebaseRealtimeDatabaseService() {
    return _instance;
  }

  // Get reference to a node
  DatabaseReference getNode(String node) {
    return _database.ref(node);
  }

  // CRUD Operations
  Future<void> createData(String node, Map<String, dynamic> data) async {
    await _database.ref(node).set(data);
  }

  Future<DataSnapshot> readData(String node) async {
    return await _database.ref(node).get();
  }

  Future<void> updateData(String node, Map<String, dynamic> data) async {
    await _database.ref(node).update(data);
  }

  Future<void> deleteData(String node) async {
    await _database.ref(node).remove();
  }
}
