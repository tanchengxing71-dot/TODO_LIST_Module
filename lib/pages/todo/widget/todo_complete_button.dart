import 'package:flutter/material.dart';

class TodoCompleteButton extends StatelessWidget {
  final bool isDone;
  final VoidCallback onToggle;

  const TodoCompleteButton({
    super.key,
    required this.isDone,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle, // 点击切换状态
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDone ? Colors.green : Colors.grey,
            width: 2,
          ),
          color: isDone ? Colors.green : Colors.transparent,
        ),
        child: isDone
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : null,
      ),
    );
  }
}
