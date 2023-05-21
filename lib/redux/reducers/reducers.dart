import 'package:app_3_redux/model/model.dart';

import 'package:app_3_redux/redux/reducers/exercise_list_reducer.dart';
import 'package:app_3_redux/redux/reducers/routine_list_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    exerciseList: exerciseListReducer(state.exerciseList, action),
    routineList: routineListReducer(state.routineList, action),
  );
}
