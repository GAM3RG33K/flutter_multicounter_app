import 'package:flutter/material.dart';
import 'package:flutter_multicounter_app/src/managers/counter_manager.dart';

import 'counter_page/counter_page.dart';
import 'managers/app_controller.dart';

/// The Widget that configures your application.
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
      appBar: AppBar(
        title: Text(currentManager.pageTitle),
      ),
      body: Builder(
        builder: (context) {
          return CounterPage(manager: currentManager);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: counterManagers
            .map(
              (manager) => BottomNavigationBarItem(
                label: manager.pageTitle,
                icon: Text(
                  '${manager.counterState}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            )
            .toList(),
        onTap: (pageIndex) => setState(() => currentPageIndex = pageIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => currentManager.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
