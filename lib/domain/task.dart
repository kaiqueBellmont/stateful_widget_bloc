class Task {
  final String name;
  bool isCompleted;

  Task(this.name, {this.isCompleted = false});

  Task copyWith({String? name, bool? isCompleted}) {
    return Task(
      name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
