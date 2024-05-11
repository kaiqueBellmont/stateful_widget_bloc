class TaskApiModel {
  final int id;
  final String name;
  final bool isCompleted;

  TaskApiModel({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  factory TaskApiModel.fromJson(Map<String, dynamic> json) {
    return TaskApiModel(
      id: json['id'],
      name: json['name'],
      isCompleted: json['is_completed'],
    );
  }
}
