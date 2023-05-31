// some [field]s are optional. If a value is null,
// filler/help text will be displayed instead

// [name]: exercise name
// [notes]: any notes user makes about the given exercise
class Exercise {
  final String name;
  final String? notes;
  final int? reps;
  final int? intensity;

  Exercise({
    required this.name,
    this.notes,
    this.reps,
    this.intensity,
  });
}

// [name]: routine name
// [exercies]: list containing the exercises
// to be done in a workout
class Routine {
  final int id;
  final String name;
  final List<Exercise>? exercises;

  Routine({
    required this.name,
    this.exercises,
  }) : id = DateTime.now().millisecondsSinceEpoch;
}

class RoutineExercise {
  final Exercise exercise;
  final int? restTimeInSeconds;

  RoutineExercise({
    required this.exercise,
    this.restTimeInSeconds,
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
