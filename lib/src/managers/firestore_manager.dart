import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreManager {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FireStoreManager._();

  static final FireStoreManager _instance = FireStoreManager._();

  factory FireStoreManager() {
    return _instance;
  }

  CollectionReference<Map<String, dynamic>> get collection =>
      fireStore.collection('counter_states');

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(int index) {
    final id = index.toString();
    final document = collection.doc(id);
    return document.get();
  }

  Future<int> getCounterState(int id) async {
    final document = await getDocument(id);
    final value = document['counter'] as int?;
    return value ?? 0;
  }

  Future<void> setCounterState(int id, int value) async {
    final document = await getDocument(id);
    await document.reference.set({
      'counter': value,
    });
  }
}
