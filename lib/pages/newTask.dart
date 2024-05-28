import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key });

  @override
  State<NewTaskPage> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("NewTask"),
      ),
    );
  }
}