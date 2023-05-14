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

// Class represeting all the state
class AppState {
  final List<Exercise> exerciseList;

  AppState({
    required this.exerciseList,
  });

  AppState.initialState() : exerciseList = [];
}
