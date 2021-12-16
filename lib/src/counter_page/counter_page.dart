import 'package:flutter/material.dart';
import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

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
    manager.fetchValueFromServer().whenComplete(() {
      // we may not need this at all
      if (!mounted) return;
      setState(() {});
    });
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
