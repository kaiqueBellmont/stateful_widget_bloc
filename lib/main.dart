import 'package:flutter/material.dart';
import 'package:stateful_widget/data/api/task_api_client.dart';
import 'package:stateful_widget/data/task_repository.dart';
import 'package:stateful_widget/domain/task.dart';
import 'package:http/http.dart' as http;
import 'package:stateful_widget/presentation/pages/add_edit_task_page.dart';

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
        _tasks = tasks!;
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
        title: const Text('Task List'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                task.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.assignment_turned_in),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditTaskPage(task: task),
                        ),
                      ).then((editedTask) {
                        if (editedTask != null) {
                          _fetchTasks();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Adicione a lógica para excluir a tarefa aqui
                    },
                  ),
                ],
              ),
              onTap: () {
                // Adicione a lógica para visualizar a tarefa aqui
              },
            ),
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
            _fetchTasks();
          }
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
