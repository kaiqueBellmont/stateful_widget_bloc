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

  static fromJson(json) {
    return Task(json['name'], isCompleted: json['is_completed']);
  }

  Object? toJson() {
    return {
      'name': name,
      'is_completed': isCompleted,
    };
  }
}
