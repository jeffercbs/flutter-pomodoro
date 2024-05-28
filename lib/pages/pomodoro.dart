import 'package:flutter/material.dart';
import 'package:myapp/widgets/chronometer.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 13, 14, 17),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Welcome to Pomodoro"),
      ),
      body: const Chronometer(),
    );
  }
}
