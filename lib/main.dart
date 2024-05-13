import 'package:flutter/material.dart';
import 'package:stateful_widget/presentation/pages/task_list_page.dart';
import 'package:stateful_widget/presentation/bloc/task_bloc.dart';
import 'package:stateful_widget/data/task_repository.dart';

void main() {
  final taskRepository = TaskRepository();
  final taskBloc = TaskBloc(taskRepository);

  runApp(MyApp(taskBloc: taskBloc));
}

class MyApp extends StatelessWidget {
  final TaskBloc taskBloc;

  MyApp({required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListPage(taskBloc: taskBloc),
    );
  }
}
