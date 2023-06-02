import 'package:app_3_redux/model/model.dart';
import 'package:flutter/material.dart';

// Display a list of exercises and perform an action when an exercise is tapped.
class ExerciseList extends StatelessWidget {
  const ExerciseList({
    super.key,
    required this.exerciseList,
    required this.onTap,
    required this.trailing,
  });

  final List<Exercise> exerciseList;
  final Icon trailing;
  final Function(Exercise exercise) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: exerciseList
          .map(
            (exercise) => GestureDetector(
              onTap: () => onTap(exercise),
              child: ListTile(
                title: Text(exercise.name),
                trailing: trailing,
              ),
            ),
          )
          .toList(),
    );
  }
}
