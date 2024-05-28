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
    return const Scaffold(
      body: Chronometer(),
    );
  }
}
