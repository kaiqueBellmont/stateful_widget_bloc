import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stateful_widget/data/task_repository.dart';
import 'package:stateful_widget/presentation/pages/add_edit_task_page.dart';
import 'package:stateful_widget/domain/task.dart';

class TaskListScreen extends StatefulWidget {
  final TaskRepository taskRepository;

  const TaskListScreen({super.key, required this.taskRepository});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() async {
    try {
      final tasks = await widget.taskRepository.fetchTasks();
      setState(() {
        _tasks = tasks;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching tasks: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final updatedTask = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditTaskPage(
                            task: task,
                            taskRepository: widget.taskRepository,
                          ),
                        ),
                      );
                      if (updatedTask != null) {
                        setState(() {
                          _tasks[index] = updatedTask;
                        });
                      }
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await widget.taskRepository.deleteTask(task.id!);
                      setState(() {
                        _tasks.removeAt(index);
                      });
                    },
                  ),
                  onTap: () async {
                    task.isCompleted = !task.isCompleted;
                    await widget.taskRepository.updateTask(task);
                    setState(() {
                      _tasks[index] = task;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTaskPage(
                taskRepository: widget.taskRepository,
              ),
            ),
          );
          if (newTask != null) {
            setState(() {
              _tasks.add(newTask);
            });
            _fetchTasks();
          }
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
