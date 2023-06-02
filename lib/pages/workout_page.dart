import 'dart:async';

import 'package:app_3_redux/model/model.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    required this.routine,
    super.key,
  });

  final Routine routine;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  int _restTimeInSeconds = 5;
  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = _timer ??
        Timer.periodic(oneSec, (timer) {
          if (_restTimeInSeconds == 0) {
            setState(() {
              _restTimeInSeconds = 5;
              _timer = null;
            });
            timer.cancel();
          } else {
            setState(() {
              _restTimeInSeconds--;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name),
      ),
      body: GestureDetector(
        onTap: () => startTimer(),
        child: Center(
          child: Text(_restTimeInSeconds.toString(),
              style: TextStyle(fontSize: 100)),
        ),
      ),
    );
  }
}
