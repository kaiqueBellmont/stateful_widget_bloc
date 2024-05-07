import 'package:flutter/material.dart';
import 'package:stateful_widget/domain/task.dart';

class AddEditTaskPage extends StatelessWidget {
  final Task? task;
  final TextEditingController _textController;

  AddEditTaskPage({Key? key, this.task})
      : _textController = TextEditingController(text: task?.name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Task Name',
          ),
          autofocus: true,
          onSubmitted: (value) {
            final updatedTask = task?.copyWith(name: value) ?? Task(value);
            Navigator.pop(context, updatedTask);
          },
        ),
      ),
    );
  }
}
