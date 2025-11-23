import '../../model/todo.dart';

class TodoListState {
  final List<Todo> list;
  final bool isAsc;

  TodoListState({this.list = const [],this.isAsc = true});

  TodoListState copyWith({List<Todo>? list,bool? isAsc}) {
    return TodoListState(
      list: list ?? this.list,
      isAsc: isAsc ?? this.isAsc
    );
  }
}
