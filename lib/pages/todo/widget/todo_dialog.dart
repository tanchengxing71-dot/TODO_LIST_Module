import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_module/model/todo.dart';

class TodoInputDialog extends StatefulWidget {
  final Function(Todo,bool) onSubmit;
  final Todo? initTodo;

  const TodoInputDialog({
    super.key,
    required this.onSubmit,
    this.initTodo,
  });

  @override
  State<TodoInputDialog> createState() => _TodoInputDialogState();
}

class _TodoInputDialogState extends State<TodoInputDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int _type = 0;
  DateTime _selectedTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // 如果传来了 Todo，自动填充
    if (widget.initTodo != null) {
      final todo = widget.initTodo!;
      _titleController.text = todo.title??"";
      _contentController.text = todo.content??"";
      _type = todo.type??0;

      try {
        _selectedTime = DateFormat('yyyy-MM-dd HH:mm').parse(todo.time??DateTime.now().toString());
      } catch (_) {
        _selectedTime = DateTime.now();
      }
    }
  }

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
    final isEdit = widget.initTodo != null;

    return AlertDialog(
      title: Text(isEdit ? "编辑 Todo" : "新增 Todo"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题框
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _titleController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: "标题",
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "标题不能为空";
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 12),

              // 内容框
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _contentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "内容",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTypeButton(0, "工作"),
                  _buildTypeButton(1, "学习"),
                  _buildTypeButton(2, "生活"),
                ],
              ),
              const SizedBox(height: 8),
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
              final formattedTime =
              DateFormat('yyyy-MM-dd HH:mm').format(_selectedTime);

              final todo = Todo(
                id: widget.initTodo?.id ?? 0, // ← 编辑模式保留 id
                title: _titleController.text,
                content: _contentController.text,
                type: _type,
                time: formattedTime,
                status: widget.initTodo?.status??0
              );

              widget.onSubmit(todo,isEdit);
              Navigator.of(context).pop();
            }
          },
          child: Text(isEdit ? "保存" : "确定"),
        ),
      ],
    );
  }

  Widget _buildTypeButton(int index, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _type == index,
      onSelected: (_) {
        setState(() {
          _type = index;
        });
      },
    );
  }
}
