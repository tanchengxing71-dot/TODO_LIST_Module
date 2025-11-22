import 'package:flutter/material.dart';

class TodoTag extends StatelessWidget {
  final int type; // 0 工作，1 学习，2 生活
  final double fontSize;
  final EdgeInsets padding;

  const TodoTag({
    super.key,
    required this.type,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
  });

  String get label {
    switch (type) {
      case 0:
        return "工作";
      case 1:
        return "学习";
      case 2:
        return "生活";
      default:
        return "未知";
    }
  }

  Color get color {
    switch (type) {
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.blueAccent;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
