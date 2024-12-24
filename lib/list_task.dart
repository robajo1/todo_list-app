import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/box.dart';

class ListTask extends StatefulWidget {
  ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Timer to delete expired tasks runs every minute(1 minute)
    _timer = Timer.periodic(
      Duration(minutes: 1),
      (timer) {
        deleteExpiredTasks();
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return taskbox.isEmpty
        ? const Center(
            child: Text('No tasks added yet'),
          )
        : ValueListenableBuilder(
            valueListenable: taskbox.listenable(),
            builder: (context, Box box, _) {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final task = box.getAt(index);
                  return ListTile(
                    title: Text(task.task_name),
                    subtitle: Text(task.task_description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        box.deleteAt(index);
                      },
                    ),
                  );
                },
              );
            },
          );
  }

  deleteExpiredTasks() {
    for (int i = 0; i < taskbox.length; i++) {
      final task = taskbox.getAt(i);
      if (task.task_date.isBefore(DateTime.now())) {
        taskbox.deleteAt(i);
      }
    }
  }
}
