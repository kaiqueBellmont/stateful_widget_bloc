class Task {
  final int? id;
  final String name;
  bool isCompleted;

  Task({this.id, required this.name, this.isCompleted = false});

  Task copyWith({int? id, String? name, bool? isCompleted}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      isCompleted: json['is_completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_completed': isCompleted,
    };
  }
}
