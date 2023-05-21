import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/actions.dart';

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
              // leading: IconButton(
              //   onPressed: () => _viewModel.onRemoveRoutine(routine),
              //   icon: const Icon(Icons.delete),
              // ),
              // trailing: Icon(Icons.edit),
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

class RoutineCreateOrEditPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            onEditRoutine(
              routine,
              Routine(name: _nameController.text),
            );
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _nameController,
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
                  if (routine.exercises != null) ...[
                    for (int i = 0; i < routine.exercises!.length; i++)
                      ExerciseListTile(
                          name: routine.exercises![i].name, index: i),
                  ],
                  if (routine.exercises == null) ...[
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
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
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
        Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text('$index.'),
              Text(name),
            ],
          ),
        ),
        Column(
          children: [
            const Text('Reps'),
            Text(reps == null ? '-' : '$reps'),
          ],
        ),
        Column(
          children: [
            const Text('Int'),
            Text(intensity == null ? '-' : '$intensity'),
          ],
        )
      ],
    );
  }
}
