import 'package:app_3_redux/model/model.dart';

class AddRoutineAction {
  final Routine routine;

  AddRoutineAction(this.routine);
}

// when user wants to edit a routine
// replaces the routine to be edited with a new updated routine
class EditRoutineAction {
  final Routine routineToEdit;
  final Routine updatedRoutine;

  EditRoutineAction(
    this.routineToEdit,
    this.updatedRoutine,
  );
}

// when user wants to delete a routine
class RemoveRoutineAction {
  final Routine routine;

  RemoveRoutineAction(this.routine);
}
