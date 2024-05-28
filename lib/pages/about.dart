import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Text(
              "About Page",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("lorem rrkea rja rjar ajra rj arja"),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
