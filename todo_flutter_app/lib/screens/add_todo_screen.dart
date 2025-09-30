import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = Provider.of<TodoProvider>(context, listen: false);
    final todo = Todo(title: _titleController.text.trim());
    await provider.addTodo(todo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Todo title', border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
                maxLength: 200,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter a title';
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Add'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Hero(
        tag: 'add_todo_btn',
        child: FloatingActionButton(
          onPressed: _submit,
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
