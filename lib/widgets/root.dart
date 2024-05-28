import 'package:flutter/material.dart';
import 'package:myapp/pages/about.dart';
import 'package:myapp/pages/dashboard.dart';
import 'package:myapp/pages/newTask.dart';
import 'package:myapp/pages/pomodoro.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootState();
}

class _RootState extends State<RootPage> {
  static const List<Widget> pages = [
    PomodoroPage(),
    DashboardPage(),
    AboutPage(),
    NewTaskPage(),
  ];

  int currentIndex = 0;

  void openInfo() {
    showModalBottomSheet(context: context, builder: (ctx) => const AboutPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 13, 14, 17),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Welcome to Pomodoro"),
        actions: [
          IconButton(
            onPressed: openInfo,
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: pages.elementAt(currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 3;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
