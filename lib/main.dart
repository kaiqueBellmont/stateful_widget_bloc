import 'package:flutter/material.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<String> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _toggleTask(int index) {
    setState(() {
      if (_tasks[index].startsWith('✔️')) {
        _tasks[index] = _tasks[index].substring(2);
      } else {
        _tasks[index] = '✔️ ${_tasks[index]}';
      }
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index, String newTask) {
    setState(() {
      _tasks[index] = newTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.purple[100],
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _tasks.clear();
            });
          },
        ),
        title: const Text('Task List', style: TextStyle(color: Colors.black87)),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index]),
            leading: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                final editedTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(task: _tasks[index]),
                  ),
                );
                if (editedTask != null) {
                  _editTask(index, editedTask);
                }
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTask(index);
              },
            ),
            onTap: () => _toggleTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (newTask != null) {
            _addTask(newTask);
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Enter Task',
          ),
          autofocus: true,
          onSubmitted: (value) {
            Navigator.pop(context, value);
          },
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatelessWidget {
  final String task;
  final TextEditingController _textController;

  EditTaskScreen({required this.task}) : _textController = TextEditingController(text: task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Edit Task',
          ),
          autofocus: true,
          onSubmitted: (value) {
            Navigator.pop(context, value);
          },
        ),
      ),
    );
  }
}
