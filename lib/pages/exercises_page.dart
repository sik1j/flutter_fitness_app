import 'package:app_3_redux/redux/actions/exercise_actions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app_3_redux/model/model.dart';

import 'package:app_3_redux/widgets/creation_page_app_bar.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

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
  final List<Exercise> exerciseList;

  final Function(Exercise exercise) onAddExercise;
  final Function(Exercise exerciseToEdit, Exercise updatedExercise)
      onEditExercise;
  final Function(Exercise exercise) onRemoveExercise;

  _ViewModel(Store<AppState> store)
      : exerciseList = store.state.exerciseList,
        onAddExercise =
            ((exercise) => store.dispatch(AddExerciseAction(exercise))),
        onEditExercise = ((exerciseToEdit, updatedExercise) => store
            .dispatch(EditExerciseAction(exerciseToEdit, updatedExercise))),
        onRemoveExercise =
            ((exercise) => store.dispatch(RemoveExerciseAction(exercise)));
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
        hintText: 'Add an exercise',
      ),
      onSubmitted: (value) {
        widget._viewModel.onAddExercise(
          Exercise(name: value, notes: 'Exercise'),
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
      children: _viewModel.exerciseList
          .map(
            (exercise) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseCreateOrEditPage(
                      exercise: exercise,
                      onEditExercise: _viewModel.onEditExercise,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(exercise.name),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          )
          .toList(),
    );
  }
}

class ExerciseCreateOrEditPage extends StatelessWidget {
  ExerciseCreateOrEditPage({
    super.key,
    required this.exercise,
    required this.onEditExercise,
  })  : _nameController = TextEditingController.fromValue(
          TextEditingValue(text: exercise.name),
        ),
        _notesController = TextEditingController.fromValue(
          TextEditingValue(text: exercise.notes ?? ''),
        );

  final Exercise exercise;
  final Function(Exercise, Exercise) onEditExercise;

  final TextEditingController _nameController;
  final TextEditingController _notesController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreationPageAppBar(
        context,
        onEdit: () => onEditExercise(
          exercise,
          Exercise(
            name: _nameController.text,
            notes: _notesController.text,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'EXERCISE NAME',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'NOTES',
              ),
            )
          ],
        ),
      ),
    );
  }
}
