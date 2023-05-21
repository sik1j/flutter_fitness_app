import 'package:app_3_redux/model/model.dart';

import 'package:app_3_redux/redux/reducers/exerciseListReducer.dart';
import 'package:app_3_redux/redux/reducers/routineListReducer.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    exerciseList: exerciseListReducer(state.exerciseList, action),
    routineList: routineListReducer(state.routineList, action),
  );
}
