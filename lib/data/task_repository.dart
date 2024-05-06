import 'package:stateful_widget/domain/task.dart';
import 'package:stateful_widget/domain/task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface {
  List<Task> _tasks = [];

  @override
  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.name == task.name);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    _tasks.removeWhere((t) => t.name == task.name);
  }
}
