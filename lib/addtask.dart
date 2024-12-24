import 'package:flutter/material.dart';
import 'package:to_do_app/Task.dart';
import 'package:to_do_app/box.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String taskname = '';
  String description = '';
  DateTime? date;
  bool isadded = false;

  var _inputkey = GlobalKey<FormState>();
  void _saveitem() {
    if (_inputkey.currentState!.validate()) {
      _inputkey.currentState!.save();

      taskbox.put(
        'key_${combineDateAndTime(_selectedDate!, _selectedTime!)}',
        Task(
          task_name: taskname,
          task_description: description,
          task_date: combineDateAndTime(_selectedDate!, _selectedTime!),
        ),
      );

      isadded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _inputkey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    (value.trim()).length <= 1 ||
                    value.length > 15) {
                  return "task name should be between 1 to 15 characters !!!";
                }
                return null;
              },
              onSaved: (value) {
                taskname = value!;
              },
              decoration: const InputDecoration(
                labelText: 'Task name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    (value.trim()).length <= 1 ||
                    value.length < 10) {
                  return "task description should be greater than 10 characters !!!";
                }
                return null;
              },
              onSaved: (value) {
                description = value!;
              },
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        validator: (value) {
                          if (_selectedDate == null) {
                            return "Please select a date.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: formatDate(_selectedDate),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickTime,
                    child: AbsorbPointer(
                      child: TextFormField(
                        validator: (value) {
                          if (_selectedDate == null) {
                            return "Please select a time.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: formatTime(_selectedTime),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _saveitem();
                if (isadded) Navigator.pop(context);
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return 'Select Time';
    return '${time.hour}:${time.minute}';
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
