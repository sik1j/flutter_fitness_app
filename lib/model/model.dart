// some [field]s are optional. If a value is null,
// filler/help text will be displayed instead

// [name]: exercise name
// [notes]: any notes user makes about the given exercise
class Exercise {
  final String name;
  final String? notes;

  Exercise({
    required this.name,
    this.notes,
  });
}

// [name]: routine name
// [exercies]: list containing the exercises
// to be done in a workout
class Routine {
  int id;
  final String name;
  final List<Exercise>? exercises;

  Routine({
    required this.name,
    int? id,
    this.exercises,
    // TODO: use a different way to generate ids
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;

  Routine copyWith({
    String? name,
    List<Exercise>? exercises,
  }) {
    return Routine(
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }
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
      : exerciseList = [
          Exercise(name: 'Push-Up', notes: 'Chest, Triceps'),
          Exercise(name: 'Pull-Up', notes: 'Lats, Biceps'),
          Exercise(name: 'Squat', notes: 'Quads, Glutes'),
        ],
        routineList = [
          Routine(name: '5x5'),
          Routine(name: 'Push, Pull, Legs'),
          Routine(name: 'Arnold Split'),
          Routine(name: 'Bro Split'),
        ];
}
