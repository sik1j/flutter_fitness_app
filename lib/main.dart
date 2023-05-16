import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/actions.dart';
import 'package:app_3_redux/redux/reducers.dart';

import 'package:app_3_redux/pages/ExercisesPage.dart';
import 'package:app_3_redux/pages/RoutinesPage.dart';

void main() {
  final Store<AppState> store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
  );
  runApp(StoreProvider(
    store: store,
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RootPage(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        RoutinesPage(),
        ExercisesPage(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bookmarks),
            label: 'Routines',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(
          () => _selectedIndex = value,
        ),
      ),
    );
  }
}
