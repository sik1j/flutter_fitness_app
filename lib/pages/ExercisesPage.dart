import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/actions.dart';

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
            (e) => ListTile(
              title: Text(e.name),
              subtitle: e.notes != '' ? Text(e.notes) : null,
              leading: IconButton(
                onPressed: () => _viewModel.onRemoveExercise(e),
                icon: const Icon(Icons.delete),
              ),
            ),
          )
          .toList(),
    );
  }
}
