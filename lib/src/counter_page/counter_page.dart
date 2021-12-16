import 'package:flutter/material.dart';
import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

/// This page is the UI visible for each specific counter page
///
/// This UI is used to represent the current status of counter managed by
/// the provided [manager]
class CounterPage extends StatefulWidget {
  final CounterManager manager;

  const CounterPage({Key? key, required this.manager}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  CounterManager get manager => widget.manager;

  @override
  void initState() {
    super.initState();
    // Sync the current counter value with firestore
    manager.fetchValueFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          // Update the counter value when the counter state changes
          ValueListenableBuilder<int>(
            valueListenable: manager.valueNotifier,
            builder: (context, value, child) {
              return Text(
                '$value',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),

          // Button increment the counter for this specific page
          ElevatedButton(
            onPressed: () {
              manager.increment();
            },
            child: const Text('Increment me!'),
          ),
        ],
      ),
    );
  }
}
