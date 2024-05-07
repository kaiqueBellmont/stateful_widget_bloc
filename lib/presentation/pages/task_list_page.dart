import 'package:flutter/material.dart';
import 'package:stateful_widget/domain/task.dart';
import 'package:stateful_widget/presentation/bloc/task_bloc.dart';
import 'package:stateful_widget/presentation/widgets/task_list_tile.dart';
import 'package:stateful_widget/presentation/pages/add_edit_task_page.dart';

class TaskListPage extends StatefulWidget {
  final TaskBloc taskBloc;

  TaskListPage({required this.taskBloc});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    super.initState();
    widget.taskBloc.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: StreamBuilder<List<Task>>(
        stream: widget.taskBloc.tasks,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = snapshot.data;

          return ListView.builder(
            itemCount: tasks?.length ?? 0,
            itemBuilder: (context, index) {
              final task = tasks![index];
              return TaskListTile(
                task: task,
                onTaskTapped: () {
                  // Toggle task completion status
                  task.isCompleted = !task.isCompleted;
                  widget.taskBloc.updateTask(task);
                },
                onDeletePressed: () {
                  widget.taskBloc.deleteTask(task);
                },
                onEditPressed: () async {
                  final updatedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditTaskPage(task: task),
                    ),
                  );
                  if (updatedTask != null) {
                    widget.taskBloc.updateTask(updatedTask);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditTaskPage()),
          );
          if (newTask != null) {
            widget.taskBloc.addTask(newTask);
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    widget.taskBloc.dispose();
    super.dispose();
  }
}
