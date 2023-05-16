// [name]: exercise name
// [notes]: any notes user makes about the given exercise
class Exercise {
  final String name;
  final String notes;

  Exercise({
    required this.name,
    required this.notes,
  });
}

class Routine {
  final String name;

  Routine({
    required this.name,
  });
}

// Class represeting all the state
class AppState {
  final List<Exercise> exerciseList;
  final List<Routine> routineList;

  AppState({
    required this.exerciseList,
    required this.routineList,
  });

  AppState.initialState()
      : exerciseList = [],
        routineList = [];
}
