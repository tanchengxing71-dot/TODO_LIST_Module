import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_module/common/router_page.dart';
import 'package:todo_list_module/pages/todo/todo_list_cubit.dart';
import 'package:todo_list_module/pages/todo/todo_list_state.dart';
import 'package:todo_list_module/pages/todo/widget/todo_dialog.dart';
import 'package:todo_list_module/pages/todo/widget/todo_filter_button.dart';
import 'package:todo_list_module/pages/todo/widget/todo_item.dart';

import '../../model/todo.dart';

class TodoListPage extends TcxRouterPage {
  const TodoListPage({super.key});

  static String path = "/pages/todoListPage";

  @override
  TcxRouterPage? routerPageBuild(Map<String, dynamic> arguments) {
    return TodoListPage();
  }

  @override
  TcxRouterPageState<TcxRouterPage> createState() => _TodoListPage();
}

class _TodoListPage extends TcxRouterPageState<TodoListPage> {
  late final TodoListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = TodoListCubit();
    _cubit.init();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _showAddTodoDialog(Todo? todo) {
    showDialog(
      context: context,
      builder: (context) {
        return TodoInputDialog(
          onSubmit: (todo, flag) {
            if (flag) {
              _cubit.update(todo);
            } else {
              _cubit.insertTodo(todo);
            }
          },
          initTodo: todo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todo List"),
          actions: [
            FilterTypeButton(
              currentType: _cubit.currentType,     // int，例如 0/1/2/-1(全部)
              onSelected: (type) {
                _cubit.currentType = type??-1;
                _cubit.queryByType();         // 你自己的逻辑
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddTodoDialog(null);
              },
            ),
          ],
        ),
        body: BlocBuilder<TodoListCubit, TodoListState>(
          builder: (context, state) {
            if (state.list.isEmpty) {
              return const Center(child: Text("暂无 Todo"));
            }
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final todo = state.list[index];
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text("确认删除？"),
                            content: const Text("删除后无法恢复"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("取消"),
                              ),
                              TextButton(
                                onPressed: () {
                                  _cubit.delete(todo);
                                  Navigator.pop(context);
                                },
                                child: const Text("删除"),
                              ),
                            ],
                          ),
                    );
                  },
                  child: TodoItem(
                    todo: todo,
                    onTap: () {
                      _showAddTodoDialog(todo);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
