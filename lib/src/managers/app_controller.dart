import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

class AppController {
  final counterManagers = <CounterManager>[
    CounterManager(0),
    CounterManager(1),
    CounterManager(2),
  ];

  CounterManager getCounterManager(int index) {
    assert(
      index < 0 || index >= counterManagers.length,
      'Index of counter must be within 0 & ${counterManagers.length}',
    );

    return counterManagers[index];
  }
}
