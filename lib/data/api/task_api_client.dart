import 'dart:convert';
import 'package:stateful_widget/domain/task.dart';
import 'package:http/http.dart' as http;

class TaskApiClient {
  static const baseUrl = 'http://10.0.2.2:8000/tasks';

  final http.Client httpClient;

  TaskApiClient({required this.httpClient});

  Future<List<Task>> getTasks() async {
    final response = await httpClient.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(Task task) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.body.isNotEmpty) {
      final dynamic data = jsonDecode(response.body);
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<Task> updateTask(Task task) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/${task.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl/$id'),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
