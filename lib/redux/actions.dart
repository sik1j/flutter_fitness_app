import 'package:app_3_redux/model/model.dart';

// when user wants to add a new exercise
class AddExerciseAction {
  final Exercise exercise;

  AddExerciseAction(this.exercise);
}

// when user wants to edit an exercise
// replaces the exericse to be edited with a new updated exercise
class EditExerciseAction {
  final Exercise exerciseToEdit;
  final Exercise updatedExercise;

  EditExerciseAction(
    this.exerciseToEdit,
    this.updatedExercise,
  );
}

// when user wants to delete an exercise
class RemoveExerciseAction {
  final Exercise exercise;

  RemoveExerciseAction(this.exercise);
}

// when user wants to add a new routine
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
