import 'package:app_3_redux/model/model.dart';

import 'package:app_3_redux/redux/actions/routine_actions.dart';

List<Routine> routineListReducer(List<Routine> routineList, dynamic action) {
  if (action is AddRoutineAction) {
    return List.from(routineList)..add(action.routine);
  }
  if (action is EditRoutineAction) {
    // return List.from(routineList)
    //   ..remove(action.routineToEdit)
    //   ..add(action.updatedRoutine);
    // return List.from(routineList)
    // ..[routineList.indexOf(action.routineToEdit)] = action.updatedRoutine;
    return routineList
        .map(
          (routine) => routine.id == action.routineToEditId
              ? action.updatedRoutine
              : routine,
        )
        .toList();
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
