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
            (e) => ListTile(
              title: Text(e.name),
              leading: IconButton(
                onPressed: () => _viewModel.onRemoveRoutine(e),
                icon: const Icon(Icons.delete),
              ),
            ),
          )
          .toList(),
    );
  }
}
