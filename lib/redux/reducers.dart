import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    exerciseList: exerciseListReducer(state.exerciseList, action),
  );
}

List<Exercise> exerciseListReducer(
    List<Exercise> exerciseList, dynamic action) {
  if (action is AddExerciseAction) {
    return List.from(exerciseList)..add(action.exercise);
  }
  if (action is EditExerciseAction) {
    return List.from(exerciseList)
      ..remove(action.exerciseToEdit)
      ..add(action.updatedExercise);
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
