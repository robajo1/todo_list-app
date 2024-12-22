// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 1)
class Task {
  Task(
      {required this.task_name,
      required this.task_description,
      required this.task_date});
  @HiveField(0)
  String task_name;

  @HiveField(1)
  String task_description;

  @HiveField(2)
  DateTime task_date;
}
