import 'package:app_3_redux/model/model.dart';
import 'package:app_3_redux/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    exerciseList: exerciseListReducer(state.exerciseList, action),
    routineList: routineListReducer(state.routineList, action),
  );
}

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

List<Routine> routineListReducer(List<Routine> routineList, dynamic action) {
  if (action is AddRoutineAction) {
    return List.from(routineList)..add(action.routine);
  }
  if (action is EditRoutineAction) {
    // return List.from(routineList)
    //   ..remove(action.routineToEdit)
    //   ..add(action.updatedRoutine);
    return List.from(routineList)
      ..[routineList.indexOf(action.routineToEdit)] = action.updatedRoutine;
  }
  if (action is RemoveRoutineAction) {
    return routineList
        .where(
          (routine) => routine != action.routine,
        )
        .toList();
  }
  return routineList;
}
