import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/Task.dart';
import 'package:to_do_app/addtask.dart';
import 'package:to_do_app/box.dart';
import 'package:to_do_app/list_task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  taskbox = await Hive.openBox('task_box');
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: todo_app(),
    ),
  );
}

class todo_app extends StatefulWidget {
  const todo_app({super.key});

  @override
  State<todo_app> createState() => _todo_appState();
}

class _todo_appState extends State<todo_app> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: ListTask(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Addtask();
    },
  );
}
