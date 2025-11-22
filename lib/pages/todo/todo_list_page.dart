import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_module/common/router_page.dart';
import 'package:todo_list_module/pages/todo/todo_list_cubit.dart';
import 'package:todo_list_module/pages/todo/todo_list_state.dart';
import 'package:todo_list_module/pages/todo/widget/todo_dialog.dart';
import 'package:todo_list_module/pages/todo/widget/todo_item.dart';

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
    //_cubit.init();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return TodoInputDialog(
          onSubmit: (todo) {
            //_cubit.insertTodo(todo);
          },
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
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddTodoDialog,
            ),
          ],
        ),
        body: BlocBuilder<TodoListCubit, TodoListState>(
          builder: (context, state) {
            if (state.list.isEmpty) {
              return const Center(
                child: Text("暂无 Todo"),
              );
            }
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final todo = state.list[index];
                return TodoItem(
                  todo: todo,
                  onTap: () {
                    // 可以添加点击事件，例如编辑或删除
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

