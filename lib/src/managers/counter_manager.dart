import 'package:flutter/cupertino.dart';

class CounterManager {
  final int id;

  CounterManager(
    this.id, {
    int counterState = 0,
  }) : valueNotifier = ValueNotifier(counterState);

  ValueNotifier<int> valueNotifier;

  int get counterState => valueNotifier.value;

  void increment() {
    valueNotifier.value = valueNotifier.value + 1;
  }

  void reset() {
    valueNotifier.value = 0;
  }

  String get pageTitle => (id + 1).toString();
}
