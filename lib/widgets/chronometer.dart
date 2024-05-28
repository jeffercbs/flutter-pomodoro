import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Chronometer extends StatefulWidget {
  const Chronometer({super.key});

  @override
  State<Chronometer> createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {
  late Timer _timer;
  late SharedPreferences _prefs;

  int _start = 0;
  int _maxTime = 60;
  bool _isRunning = false;
  String title = 'Pomodoro';
  List logs = [];

  int _reps = 0;

  static const shortBreakMin = 5;
  static const longBreakMin = 20;
  static const workMin = 1;

  void startTimer() {
    const shortSec = shortBreakMin * 60;
    const longSec = longBreakMin * 60;
    const workSec = workMin * 60;

    if (!_isRunning) {
      setState(() {
        _isRunning = true;
        _reps += 1;
      });

      if (_reps % 8 == 0) {
        setState(() {
          title = 'Long Break';
        });
        counterDown(longSec);
      } else if (_reps % 2 == 0) {
        setState(() {
          title = 'Short Break';
        });
        counterDown(shortSec);
      } else {
        setState(() {
          title = 'Work';
        });
        counterDown(workSec);
      }
    } else {
      stopTimer();
    }
  }

  void stopTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _start = 0;
      _maxTime = 60;
      _isRunning = false;
      logs = [];
      _reps = 0;
      title = 'Puedes empezar';
    });
  }

  void counterDown(int count) {
    setState(() {
      _start = count;
      _maxTime = count;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        logs.add({
          'title': title,
          'time': _maxTime,
          'date': DateTime.now(),
        });
        startTimer();
      }
    });
  }

  String formattingSec(int seconds) {
    int mins = seconds ~/ 60;
    int sec = seconds % 60;

    String timerStr = "";

    sec < 10 ? timerStr = '$mins:0$sec' : timerStr = '$mins:$sec';

    return timerStr;
  }

  String formattedDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Future<void> savedData() async {
    await _prefs.setString("data", logs.toString());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 13, 14, 17),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: _start / _maxTime),
                duration: const Duration(milliseconds: 500),
                builder: (context, double value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 14,
                          backgroundColor: Colors.grey.shade600,
                          valueColor: _start <= 10
                              ? const AlwaysStoppedAnimation<Color>(Colors.red)
                              : const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                        ),
                      ),
                      Text(
                        formattingSec(_start),
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      backgroundColor: _isRunning ? Colors.red : Colors.green,
                      foregroundColor: Colors.white),
                  onPressed: startTimer,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  onPressed: _isRunning ? resetTimer : null,
                  child: const Text('Reset'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
