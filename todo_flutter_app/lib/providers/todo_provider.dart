import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

/// Provider that holds application state for todos and handles persistence.
class TodoProvider extends ChangeNotifier {
  static const _storageKey = 'todos_json';
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  /// Loads todos from SharedPreferences. Uses async/await.
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_storageKey);
    if (json != null && json.isNotEmpty) {
      try {
        final decoded = Todo.decodeList(json);
        _todos.clear();
        _todos.addAll(decoded);
      } catch (e) {
        // If decoding fails, just start fresh.
        _todos.clear();
      }
    }
    notifyListeners();
  }

  /// Persists current todos to SharedPreferences.
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final json = Todo.encodeList(_todos);
    await prefs.setString(_storageKey, json);
  }

  /// Add a new todo and persist.
  Future<void> addTodo(Todo todo) async {
    _todos.insert(0, todo); // newest on top
    await _saveTodos();
    notifyListeners();
  }

  /// Toggle completion and persist.
  Future<void> toggleTodo(int index) async {
    if (index < 0 || index >= _todos.length) return;
    _todos[index].isDone = !_todos[index].isDone;
    await _saveTodos();
    notifyListeners();
  }

  /// Delete a todo and persist.
  Future<void> deleteTodo(int index) async {
    if (index < 0 || index >= _todos.length) return;
    _todos.removeAt(index);
    await _saveTodos();
    notifyListeners();
  }

  /// Filter helpers (not exposed as separate lists to keep a single source of truth).
  List<Todo> filtered({bool? done}) {
    if (done == null) return todos;
    return _todos.where((t) => t.isDone == done).toList();
  }
}
