import 'package:flutter/material.dart';
import 'package:stateful_widget/data/api/task_api_client.dart';
import 'package:stateful_widget/data/task_repository.dart';
import 'package:http/http.dart' as http;
import 'package:stateful_widget/presentation/pages/task_list_page.dart';

void main() {
  final taskApiClient = TaskApiClient(httpClient: http.Client());
  final taskRepository = TaskRepository(apiClient: taskApiClient);

  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(taskRepository: taskRepository),
    );
  }
}
