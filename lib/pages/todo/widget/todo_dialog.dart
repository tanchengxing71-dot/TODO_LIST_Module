import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_module/model/todo.dart';

class TodoInputDialog extends StatefulWidget {
  final Function(Todo) onSubmit;

  const TodoInputDialog({super.key, required this.onSubmit});

  @override
  State<TodoInputDialog> createState() => _TodoInputDialogState();
}

class _TodoInputDialogState extends State<TodoInputDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int _type = 0; // 0 工作, 1 学习, 2 生活
  DateTime _selectedTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  // 打开时间选择器
  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedTime),
      );

      if (time != null) {
        setState(() {
          _selectedTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("新增 Todo"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title 输入框
              TextFormField(
                controller: _titleController,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "标题",
                  counterText: "", // 去掉右下角计数
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "标题不能为空";
                  return null;
                },
              ),

              const SizedBox(height: 8),

              // Content 输入框
              TextFormField(
                controller: _contentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "内容",
                ),
              ),

              const SizedBox(height: 8),

              // Type 选择器
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTypeButton(0, "工作"),
                  _buildTypeButton(1, "学习"),
                  _buildTypeButton(2, "生活"),
                ],
              ),

              const SizedBox(height: 8),

              // 时间选择器
              Row(
                children: [
                  const Text("截止时间: "),
                  TextButton(
                    onPressed: _pickDateTime,
                    child: Text(DateFormat('yyyy-MM-dd HH:mm').format(_selectedTime)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("取消"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final todo = Todo(
                title: _titleController.text,
                content: _contentController.text,
                type: _type,
                time: DateFormat('yyyy-MM-dd HH:mm').format(_selectedTime),
              );
              widget.onSubmit(todo);
              Navigator.of(context).pop();
            }
          },
          child: const Text("确定"),
        ),
      ],
    );
  }

  Widget _buildTypeButton(int index, String label) {
    final isSelected = _type == index;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _type = index;
        });
      },
    );
  }
}
