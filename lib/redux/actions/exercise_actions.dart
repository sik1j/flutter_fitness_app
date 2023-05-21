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
