import 'package:flutter/material.dart';
import 'package:stateful_widget/domain/task.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskTapped;
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;

  const TaskListTile({
    super.key,
    required this.task,
    required this.onTaskTapped,
    required this.onDeletePressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.name,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onEditPressed,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDeletePressed,
      ),
      onTap: onTaskTapped,
    );
  }
}
