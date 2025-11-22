import '../../model/todo.dart';

class TodoListState {
  final List<Todo> list;

  TodoListState({this.list = const []});

  TodoListState copyWith({List<Todo>? list}) {
    return TodoListState(
      list: list ?? this.list,
    );
  }
}
