import 'package:flutter/material.dart';
import 'package:stateful_widget/data/api/task_api_client.dart';
import 'package:stateful_widget/data/task_repository.dart';
import 'package:stateful_widget/domain/task.dart';
import 'package:http/http.dart' as http;

void main() {
  final taskApiClient = TaskApiClient(httpClient: http.Client());
  final taskRepository = TaskRepository(apiClient: taskApiClient);

  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  MyApp({required this.taskRepository});

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

class TaskListScreen extends StatefulWidget {
  final TaskRepository taskRepository;

  TaskListScreen({super.key, required this.taskRepository});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
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
      print('Error fetching tasks: $e');
      // Aqui você pode exibir uma mensagem de erro para o usuário, se desejar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task.name),
            // Implemente outras partes do ListTile conforme necessário
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implemente a lógica para adicionar uma nova tarefa
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
