import 'package:flutter/material.dart';
import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

import 'counter_page/counter_page.dart';
import 'managers/app_controller.dart';

/// The Widget that is the Main UI of the app & root of the Widget tree
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = AppController();

    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _HomePage(appController: appController),
    );
  }
}

class _HomePage extends StatefulWidget {
  final AppController appController;

  const _HomePage({Key? key, required this.appController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  AppController get appController => widget.appController;

  List<CounterManager> get counterManagers => appController.counterManagers;

  int currentPageIndex = 0;

  CounterManager get currentManager => counterManagers[currentPageIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // THis forces to Rebuild if the page index changes
      key: ValueKey(currentPageIndex),
      appBar: AppBar(
        title: Text(currentManager.pageTitle),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Reset All'),
                onTap: () {
                  // reset counter state of all pages
                  for (var manager in appController.counterManagers) {
                    manager.reset();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          return CounterPage(manager: currentManager);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        items: counterManagers
            .map(
              (manager) => BottomNavigationBarItem(
                label: manager.pageTitle,
                icon: const Icon(Icons.calculate),
              ),
            )
            .toList(),
        onTap: (pageIndex) {
          // Set the index & set state to rebuild the UI
          setState(() => currentPageIndex = pageIndex);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => currentManager.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
