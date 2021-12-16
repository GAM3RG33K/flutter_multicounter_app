import 'package:flutter/material.dart';
import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

class CounterPage extends StatelessWidget {
  final CounterManager manager;

  const CounterPage({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          ValueListenableBuilder<int>(
            valueListenable: manager.valueNotifier,
            builder: (context, value, child) {
              return Text(
                '$value',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
        ],
      ),
    );
  }
}
