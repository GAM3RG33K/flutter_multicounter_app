import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

/// This class is the controller class for app
///
/// It handle the app's overall management
///
/// In this scenario only maintaining a list counter managers & a providing the
/// counter on request is the only task done by this class
class AppController {
  final counterManagers = <CounterManager>[
    CounterManager(0),
    CounterManager(1),
    CounterManager(2),
  ];

  /// Method to get counter manager associated with [index]
  CounterManager getCounterManager(int index) {
    /// Assertion to prevent invalid index values
    assert(
      index < 0 || index >= counterManagers.length,
      'Index of counter must be within 0 & ${counterManagers.length}',
    );

    return counterManagers[index];
  }
}
