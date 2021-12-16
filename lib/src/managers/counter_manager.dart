import 'package:flutter/cupertino.dart';

import 'firestore_manager.dart';

class CounterManager {
  final int id;

  CounterManager(
    this.id, {
    int counterState = 0,
  }) : valueNotifier = ValueNotifier(counterState);

  ValueNotifier<int> valueNotifier;

  int get counterState => valueNotifier.value;

  final fireStore = FireStoreManager();

  Future<void> fetchValueFromServer() async {
    final _newValue = await fireStore.getCounterState(id);
    valueNotifier.value = _newValue;
  }

  void increment() {
    valueNotifier.value = valueNotifier.value + 1;
    fireStore.setCounterState(id, counterState);
  }

  void reset() {
    valueNotifier.value = 0;
  }

  String get pageTitle => (id + 1).toString();
}
