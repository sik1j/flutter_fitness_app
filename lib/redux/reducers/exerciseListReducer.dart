import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/actions.dart';

List<Exercise> exerciseListReducer(
    List<Exercise> exerciseList, dynamic action) {
  if (action is AddExerciseAction) {
    return List.from(exerciseList)..add(action.exercise);
  }
  // find index of exercise to update
  // return a copy of list with the exercise to update replaced with
  // the updated exercise
  if (action is EditExerciseAction) {
    // return List.from(exerciseList)
    //   ..remove(action.exerciseToEdit)
    //   ..add(action.updatedExercise);
    return List.from(exerciseList)
      ..[exerciseList.indexOf(action.exerciseToEdit)] = action.updatedExercise;
  }
  if (action is RemoveExerciseAction) {
    return exerciseList
        .where(
          (exercise) => exercise != action.exercise,
        )
        .toList();
  }
  return exerciseList;
}
