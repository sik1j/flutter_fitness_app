import 'package:app_3_redux/redux/actions/routine_actions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app_3_redux/model/model.dart';

import 'package:app_3_redux/widgets/creation_page_app_bar.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StoreConnector<AppState, _ViewModel>(
        builder: (context, viewModel) => ListView(
          children: [
            AddItemWidget(viewModel),
            ItemListWidget(viewModel),
          ],
        ),
        converter: (store) => _ViewModel(store),
      ),
    );
  }
}

class _ViewModel {
  final List<Routine> routineList;

  final Function(Routine routine) onAddRoutine;
  final Function(Routine routineToEdit, Routine updatedRoutine) onEditRoutine;
  final Function(Routine routine) onRemoveRoutine;

  _ViewModel(Store<AppState> store)
      : routineList = store.state.routineList,
        onAddRoutine = ((routine) => store.dispatch(AddRoutineAction(routine))),
        onEditRoutine = ((routineToEdit, updatedRoutine) =>
            store.dispatch(EditRoutineAction(routineToEdit, updatedRoutine))),
        onRemoveRoutine =
            ((routine) => store.dispatch(RemoveRoutineAction(routine)));
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel _viewModel;
  const AddItemWidget(this._viewModel, {super.key});

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'Add a routine',
      ),
      onSubmitted: (value) {
        widget._viewModel.onAddRoutine(
          Routine(name: value),
        );
        _controller.text = '';
      },
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final _ViewModel _viewModel;
  const ItemListWidget(this._viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _viewModel.routineList
          .map(
            (routine) => ListTile(
              title: Text(routine.name),
              trailing: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoutineCreateOrEditPage(
                      routine: routine,
                      onEditRoutine: (routineToEdit, updatedRoutine) =>
                          _viewModel.onEditRoutine(
                              routineToEdit, updatedRoutine),
                    ),
                  ),
                ),
                icon: const Icon(Icons.edit),
              ),
            ),
          )
          .toList(),
    );
  }
}

class RoutineCreateOrEditPage extends StatefulWidget {
  RoutineCreateOrEditPage({
    super.key,
    required this.routine,
    required this.onEditRoutine,
  }) : _nameController = TextEditingController.fromValue(
          TextEditingValue(text: routine.name),
        );

  final Routine routine;
  final Function(Routine, Routine) onEditRoutine;

  final TextEditingController _nameController;

  @override
  State<RoutineCreateOrEditPage> createState() =>
      _RoutineCreateOrEditPageState();
}

class _RoutineCreateOrEditPageState extends State<RoutineCreateOrEditPage> {
  List<RoutineExercise>? _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = widget.routine.exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreationPageAppBar(
        context,
        onEdit: () => widget.onEditRoutine(
          widget.routine,
          Routine(name: widget._nameController.text, exercises: _exercises),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: widget._nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'EXERCISE NAME',
                ),
              ),
            ),
            const Text('EXERCISES:'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  if (_exercises != null) ...[
                    for (int i = 0; i < _exercises!.length; i++) ...[
                      GestureDetector(
                        onTap: () async {
                          _exercises![i] = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoutineExerciseEditingPage(
                                  routineExercise: _exercises![i]),
                            ),
                          );
                        },
                        child: ExerciseListTile(
                            name: _exercises![i].name, index: i),
                      ),
                      const Divider(
                        indent: 12,
                        endIndent: 12,
                      ),
                    ],
                  ],
                  if (_exercises == null) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No Exercises Yet'),
                    )
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var selectedExercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionPage()),
          );
          if (selectedExercise != null) {
            setState(() {
              _exercises ??= [];
              _exercises = [..._exercises!, selectedExercise];
            });
          }
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Page to select exercises
class ExerciseSelectionPage extends StatefulWidget {
  const ExerciseSelectionPage({super.key});

  @override
  State<ExerciseSelectionPage> createState() => _ExerciseSelectionPageState();
}

class _ExerciseSelectionPageState extends State<ExerciseSelectionPage> {
  List<RoutineExercise>? _exercisesAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Select Exercises'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context, _exercisesAdded),
            icon: const Icon(Icons.arrow_back_ios),
          )),
      body: StoreConnector<AppState, List<Exercise>>(
        builder: (context, viewModel) => ListView(
          children: [
            for (int i = 0; i < viewModel.length; i++)
              ListTile(
                title: Text(viewModel[i].name),
                trailing: IconButton(
                    // return the exercise that was selected as a RoutineExercise
                    onPressed: () => Navigator.pop(
                          context,
                          RoutineExercise(
                            exercise: viewModel[i],
                          ),
                        ),
                    icon: const Icon(Icons.add)),
              ),
          ],
        ),
        converter: (store) => store.state.exerciseList,
      ),
    );
  }
}

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile({
    super.key,
    required this.name,
    this.reps,
    this.intensity,
    required this.index,
  });

  final String name;
  final int index;
  final int? reps;
  final int? intensity;

  @override
  Widget build(BuildContext context) {
    return
        // 3 columns, with a title and subtitle
        Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
      // color: Colors.deepPurple.shade200,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$index.'),
                Text(name),
              ],
            ),
            Column(
              children: [
                const Text('Reps'),
                Text(reps == null ? '-' : '$reps'),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const Text('Int'),
                Text(intensity == null ? '-' : '$intensity'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RoutineExerciseEditingPage extends StatelessWidget {
  RoutineExerciseEditingPage({
    required this.routineExercise,
    super.key,
  }) : _restTimeInSecondsController = TextEditingController.fromValue(
          TextEditingValue(
            text: routineExercise.restTimeInSeconds == null
                ? ''
                : routineExercise.restTimeInSeconds.toString(),
          ),
        );

  final RoutineExercise routineExercise;
  TextEditingController _restTimeInSecondsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Routine'),
        leading: IconButton(
          onPressed: () => Navigator.pop(
            context,
            RoutineExercise(
              exercise: routineExercise.exercise,
              restTimeInSeconds: _restTimeInSecondsController.text == ''
                  ? null
                  : int.parse(_restTimeInSecondsController.text),
            ),
          ),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(routineExercise.name),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.change_circle),
                    ),
                  ],
                ),
                const Divider(),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rest',
                    hintText: 'Optional',
                  ),
                  controller: _restTimeInSecondsController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
