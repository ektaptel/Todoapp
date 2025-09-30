import 'package:flutter/material.dart';
import '../models/todo.dart';

/// Small reusable widget that represents a Todo row.
class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  const TodoTile({required this.todo, this.onToggle, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          todo.title,
          style: TextStyle(decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        leading: Checkbox(value: todo.isDone, onChanged: (_) => onToggle?.call()),
        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: onDelete),
      ),
    );
  }
}
