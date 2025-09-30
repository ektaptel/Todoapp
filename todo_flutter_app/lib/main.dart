import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final todoProvider = TodoProvider();
  await todoProvider.loadTodos(); // load persisted todos before app starts
  runApp(MyApp(todoProvider: todoProvider));
}

class MyApp extends StatelessWidget {
  final TodoProvider todoProvider;
  const MyApp({required this.todoProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: todoProvider,
      child: MaterialApp(
        title: 'Todo Flutter App',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/add': (_) => const AddTodoScreen(),
        },
      ),
    );
  }
}
