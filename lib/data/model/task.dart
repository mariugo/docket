class Task {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todos,
  });

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) =>
      Task(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        todos: todos ?? todos,
      );

  factory Task.fromJson(Map _json) => Task(
        title: _json['title'],
        icon: _json['icon'],
        color: _json['color'],
        todos: _json['todos'],
      );

  Map toJson() => {
        'title': title,
        'icon': icon,
        'color': color,
        'todos': todos,
      };
}
