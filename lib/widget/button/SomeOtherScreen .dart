import 'package:flutter/material.dart';

class SomeOtherScreen extends StatelessWidget {
  final String title;
  final String calorie;

  const SomeOtherScreen({required this.title, required this.calorie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Calories: $calorie'),
      ),
    );
  }
}
