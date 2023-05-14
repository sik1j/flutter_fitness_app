class Exercise {
  final String name;
  final String notes;

  Exercise({
    required this.name,
    required this.notes,
  });
}

class AppState {
  final List<Exercise> exercisesList;

  AppState({
    required this.exercisesList,
  });

  AppState.initialState() : exercisesList = [];
}
