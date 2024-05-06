import 'dart:async';
import 'package:stateful_widget/domain/task.dart';
import 'package:stateful_widget/domain/task_repository_interface.dart';

class TaskBloc {
  final TaskRepositoryInterface _repository;

  final _tasksController = StreamController<List<Task>>.broadcast();

  Stream<List<Task>> get tasks => _tasksController.stream;

  TaskBloc(this._repository);

  void fetchTasks() async {
    final tasks = await _repository.getTasks();
    _tasksController.sink.add(tasks);
  }

  void addTask(Task task) async {
    await _repository.addTask(task);
    fetchTasks();
  }

  void updateTask(Task task) async {
    await _repository.updateTask(task);
    fetchTasks();
  }

  void deleteTask(Task task) async {
    await _repository.deleteTask(task);
    fetchTasks();
  }

  void dispose() {
    _tasksController.close();
  }
}
