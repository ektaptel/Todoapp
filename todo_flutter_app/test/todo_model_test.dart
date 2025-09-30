import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter_app/models/todo.dart';

void main() {
  test('Todo serialization roundtrip', () {
    final t = Todo(title: 'Sample', isDone: true);
    final json = t.toJson();
    final back = Todo.fromJson(json);
    expect(back.title, equals('Sample'));
    expect(back.isDone, equals(true));
  });
}
