import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_module/model/todo.dart';
import 'package:todo_list_module/native/todo_channel.dart';
import 'package:todo_list_module/pages/todo/todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState());

  int currentType = -1;

  Future<void> insertTodo(Todo todo) async {
    final id = await TodoChannel.insert(todo);
    if (id != null && id > 0) {
      fetchList();
    }
  }

  Future<void> queryAll() async {
    final list = await TodoChannel.queryAll();
    emit(state.copyWith(list: list));
  }

  Future<void> queryByType() async {
    if (currentType == -1) {
      queryAll();
      return;
    }
    final list = await TodoChannel.queryByType(currentType);
    emit(state.copyWith(list: list));
  }

  Future<void> update(Todo todo) async {
    final id = await TodoChannel.update(todo);
    if (id != null && id > 0) {
      fetchList();
    }
  }

  Future<void> changeStatus(Todo todo) async {
    todo = todo.copyWith(status: todo.status == 0 ? 1 : 0);
    final updatedId = await TodoChannel.update(todo);
    if (updatedId == null || updatedId <= 0) return;

    final newList =
        state.list.map((t) {
          return t.id == todo.id
              ? t.copyWith(status: t.status == 0 ? 1 : 0)
              : t;
        }).toList();
    emit(state.copyWith(list: newList));
  }

  Future<void> delete(Todo todo) async {
    final id = await TodoChannel.delete(todo);
    if (id != null && id > 0) {
      fetchList();
    }
  }

  Future fetchList() async {
    if (currentType == -1) {
      queryAll();
    } else {
      queryByType();
    }
  }

  Future reverseList() async {
    final list = state.list;
    emit(state.copyWith(list: list.reversed.toList(), isAsc: !state.isAsc));
  }

  init() {
    fetchList();
  }
}
