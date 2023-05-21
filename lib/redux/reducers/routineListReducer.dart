import 'package:app_3_redux/model/model.dart';

import '../actions/RoutineActions.dart';

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
