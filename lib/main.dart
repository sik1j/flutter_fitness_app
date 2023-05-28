import 'package:app_3_redux/redux/actions/exercise_actions.dart';
import 'package:app_3_redux/redux/actions/routine_actions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/reducers/reducers.dart';

import 'package:app_3_redux/pages/exercises_page.dart';
import 'package:app_3_redux/pages/routines_page.dart';

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
        const RoutinesPage(),
        const ExercisesPage(),
      ].elementAt(_selectedIndex),
      floatingActionButton: StoreConnector<AppState, _ViewModel>(
        builder: (context, viewModel) => FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  if (_selectedIndex == 0) {
                    Routine newRoutine = Routine(
                      name: 'New Routine',
                    );
                    return RoutineCreateOrEditPage(
                      // routine: Routine(
                      //   name: 'New Routine',
                      // ),
                      routineId: newRoutine.id,
                      routineList: viewModel.routineList,
                      onEditRoutine: (routineToEdit, updatedRoutine) {
                        viewModel.onAddRoutine(routineToEdit);
                        viewModel.onEditRoutine(
                            routineToEdit.id, updatedRoutine);
                      },
                    );
                  } else {
                    return ExerciseCreateOrEditPage(
                      exercise: Exercise(
                        name: 'New Exercise',
                      ),
                      onEditExercise: (exerciseToEdit, updatedExercise) {
                        viewModel.onAddExercise(exerciseToEdit);
                        viewModel.onEditExercise(
                            exerciseToEdit, updatedExercise);
                      },
                    );
                  }
                },
              ),
            );
          },
          label: Row(
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 10),
              Text(_selectedIndex == 0 ? 'Routine' : 'Exercise'),
            ],
          ),
        ),
        converter: (store) => _ViewModel(store),
      ),
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

// _ViewModel is a class that contains the data and functions that the
// StoreConnector will need to build the UI.
// defines onEditExercise, onAddExercise and
// onEditRoutine, onAddRoutine functions
class _ViewModel {
  final Function(Exercise exerciseToEdit, Exercise updatedExercise)
      onEditExercise;
  final Function(Exercise exercise) onAddExercise;

  final Function(int routineToEditId, Routine updatedRoutine) onEditRoutine;
  final Function(Routine routine) onAddRoutine;

  final List<Routine> routineList;

  _ViewModel(Store<AppState> store)
      : routineList = store.state.routineList,
        onEditExercise = ((exerciseToEdit, updatedExercise) => store
            .dispatch(EditExerciseAction(exerciseToEdit, updatedExercise))),
        onAddExercise =
            ((exercise) => store.dispatch(AddExerciseAction(exercise))),
        onEditRoutine = ((routineToEditId, updatedRoutine) =>
            store.dispatch(EditRoutineAction(routineToEditId, updatedRoutine))),
        onAddRoutine = ((routine) => store.dispatch(AddRoutineAction(routine)));
}
