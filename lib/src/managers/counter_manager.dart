import 'package:flutter/cupertino.dart';

import 'firestore_manager.dart';

/// This class is responsible to manage the counter on each individual page
/// in this app.
///
/// Each counter manager works independently of each other & maintains the
/// counter state for associated unique [id]
///
/// The same [id] is used to read/write the counter state in fireStore
class CounterManager {
  final int id;

  CounterManager(
    this.id, {
    int counterState = 0,
  }) : valueNotifier = ValueNotifier(counterState);

  /// The instance of the firestore manager used for read/write to firestore
  final fireStore = FireStoreManager();

  /// This notifier is responsible to notify the widgets to update the
  /// associated Counter page UI
  ValueNotifier<int> valueNotifier;

  int get counterState => valueNotifier.value;

  /// Method to fetch the latest value of counter associated with [id]
  Future<void> fetchValueFromServer() async {
    final _newValue = await fireStore.getCounterState(id);
    valueNotifier.value = _newValue;
  }

  /// Method to increment the current state of the counter
  void increment() {
    valueNotifier.value = valueNotifier.value + 1;

    // Sync new value with firestore
    fireStore.setCounterState(id, counterState);
  }

  /// Method to reset the counter value to 0
  void reset() {
    valueNotifier.value = 0;

    // Sync new value with firestore
    fireStore.setCounterState(id, counterState);
  }

  /// A utility getter to generate page title based on provided [id]
  String get pageTitle => 'Counter ${id + 1}';
}
