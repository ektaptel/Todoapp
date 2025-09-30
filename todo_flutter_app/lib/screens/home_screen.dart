import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_tile.dart';
import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _filter = 'all'; // all | pending | done
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    List<Todo> display;
    if (_filter == 'pending') {
      display = provider.filtered(done: false);
    } else if (_filter == 'done') {
      display = provider.filtered(done: true);
    } else {
      display = provider.todos;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) => setState(() => _filter = v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'all', child: Text('All')),
              PopupMenuItem(value: 'pending', child: Text('Pending')),
              PopupMenuItem(value: 'done', child: Text('Completed')),
            ],
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: display.isEmpty
                    ? const Center(key: ValueKey('empty'), child: Text('No todos yet. Tap + to add.'))
                    : ListView.builder(
                        key: ValueKey('list_${display.length}_$_filter'),
                        itemCount: display.length,
                        itemBuilder: (context, index) {
                          // Map the displayed index to original list index
                          final originalIndex = provider.todos.indexOf(display[index]);
                          return Dismissible(
                            key: ValueKey(display[index].title + originalIndex.toString()),
                            background: Container(color: Colors.redAccent, alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 20), child: const Icon(Icons.delete, color: Colors.white)),
                            secondaryBackground: Container(color: Colors.redAccent, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                            onDismissed: (_) async => await provider.deleteTodo(originalIndex),
                            child: TodoTile(
                              todo: display[index],
                              onToggle: () async => await provider.toggleTodo(originalIndex),
                              onDelete: () async => await provider.deleteTodo(originalIndex),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Hero(
        tag: 'add_todo_btn',
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
