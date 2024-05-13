class Task {
  final String name;
  bool isCompleted;

  Task(this.name, {this.isCompleted = false});

  get id => null;

  Task copyWith({String? name, bool? isCompleted}) {
    return Task(
      name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(json['name'], isCompleted: json['is_completed']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'is_completed': isCompleted,
    };
  }
}
