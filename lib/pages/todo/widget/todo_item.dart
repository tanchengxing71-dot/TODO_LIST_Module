import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_module/model/todo.dart';
import 'package:todo_list_module/pages/todo/todo_list_cubit.dart';
import 'package:todo_list_module/pages/todo/widget/todo_complete_button.dart';
import 'package:todo_list_module/pages/todo/widget/todo_tag.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onTap;

  const TodoItem({
    super.key,
    required this.todo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                children: [
                  Text(
                    todo.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TodoCompleteButton(isDone: todo.status == 1, onToggle:(){
                    context.read<TodoListCubit>().changeStatus(todo);
                  })
                ],
              ),
              const SizedBox(height: 3),
              TodoTag(type: todo.type??0),
              const SizedBox(height: 6),
              // Content: 固定高度，最多三行，超出省略
              Text(
                todo.content ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // Time
              Text(
                todo.time ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
