import 'package:flutter/material.dart';

void main() {
  runApp(const todo_app());
}

class todo_app extends StatefulWidget {
  const todo_app({super.key});

  @override
  State<todo_app> createState() => _todo_appState();
}

class _todo_appState extends State<todo_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do App'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
