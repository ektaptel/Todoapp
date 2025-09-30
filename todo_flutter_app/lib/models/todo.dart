import 'dart:convert';

/// Todo model represents a single todo item.
class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  /// Construct from JSON map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String? ?? '',
      isDone: json['isDone'] as bool? ?? false,
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  /// Helper to encode a list of todos to JSON string.
  static String encodeList(List<Todo> todos) => jsonEncode(todos.map((t) => t.toJson()).toList());

  /// Helper to decode from JSON string to list of todos.
  static List<Todo> decodeList(String todosJson) {
    final List<dynamic> list = jsonDecode(todosJson) as List<dynamic>;
    return list.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();
  }
}
