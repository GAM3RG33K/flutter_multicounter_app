import 'package:cloud_firestore/cloud_firestore.dart';

/// This class is responsible for communicating with the firestore
/// database
///
/// It also has a set of utility methods & getters to ease the communication
/// without much setup or dependencies
class FireStoreManager {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// Prevent instantiation out side of this class
  FireStoreManager._();

  /// Basic setup for singleton instance
  static final FireStoreManager _instance = FireStoreManager._();

  factory FireStoreManager() {
    return _instance;
  }

  CollectionReference<Map<String, dynamic>> get collection =>
      fireStore.collection('counter_states');

  Future<DocumentSnapshot<Map<String, dynamic>>> _getDocument(int index) {
    final id = index.toString();
    final document = collection.doc(id);
    return document.get();
  }

  /// Method to fetch counter for provided [id]
  Future<int> getCounterState(int id) async {
    final document = await _getDocument(id);
    final _data = document.data();
    final value = _data?['counter'] as int?;
    return value ?? 0;
  }

  /// Method to update counter for provided [id] with [value]
  Future<void> setCounterState(int id, int value) async {
    final document = await _getDocument(id);
    await document.reference.set({
      'counter': value,
    });
  }
}
