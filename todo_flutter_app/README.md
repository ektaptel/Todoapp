# Flutter Todo App

A small Todo List Flutter app built with Provider state management and SharedPreferences persistence.

## Features
- Home screen: shows list of todos.
- Add Todo screen: add new todos with validation.
- Toggle complete/incomplete.
- Delete via swipe (Dismissible).
- Local persistence using SharedPreferences (stored as JSON).
- Provider for state management.
- Simple animations: Hero for add button, AnimatedSwitcher for list updates.
- Null-safe Dart, clean code, async/await for persistence.
- Includes a simple unit test for the Todo model.

## Design Choices
- **SharedPreferences** chosen for simplicity and zero setup for small data sets. Uses JSON encoding for list persistence.
- **Provider** keeps the app light-weight and easy to reason about for this size of app.
- UI follows Material Design with padding and responsive layout. Uses `CheckboxListTile` for clear affordance.
- File structure separated into `models`, `providers`, `screens`, and `widgets` for clarity and separation of concerns.

 
## Known limitations
- Uses SharedPreferences; for larger datasets consider Hive or Sqflite.
- No persistence migration/versioning.
- Minimal accessibility support — can be extended.

Enjoy!

