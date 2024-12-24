import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Ensure you import this for HiveListenable
import 'package:to_do_app/box.dart';

class ListTask extends StatelessWidget {
  const ListTask({super.key});

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
}
