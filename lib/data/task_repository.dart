import 'package:stateful_widget/data/api/task_api_client.dart';
import 'package:stateful_widget/domain/task.dart';

class TaskRepository {
  final TaskApiClient _apiClient;

  TaskRepository({required TaskApiClient apiClient}) : _apiClient = apiClient;

  Future<List<Task>> fetchTasks() async {
    return await _apiClient.getTasks();
  }

  Future<Task> addTask(Task task) async {
    return _apiClient.addTask(task);
  }

  Future<Task> updateTask(Task task) async {
    return _apiClient.updateTask(task);
  }

  Future<void> deleteTask(int id) async {
    return _apiClient.deleteTask(id);
  }
}
