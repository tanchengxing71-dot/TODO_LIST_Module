import 'package:flutter/material.dart';

class FilterTypeButton extends StatelessWidget {
  final int? currentType; // null 表示全部
  final ValueChanged<int?> onSelected;

  const FilterTypeButton({
    super.key,
    required this.currentType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        _openFilterSheet(context);
      },
    );
  }

  void _openFilterSheet(BuildContext context) async {
    final result = await showModalBottomSheet<int?>(
      context: context,
      builder: (context) {
        return _FilterSheet(currentType: currentType);
      },
    );

    if(result!=null){
      onSelected(result);
    }
  }
}

class _FilterSheet extends StatelessWidget {
  final int? currentType;

  const _FilterSheet({required this.currentType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildItem(context, -1, "全部"),
          _buildItem(context, 0, "工作"),
          _buildItem(context, 1, "学习"),
          _buildItem(context, 2, "生活"),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int? value, String label) {
    final selected = value == currentType;

    return ListTile(
      title: Text(label),
      trailing: selected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () => Navigator.pop(context, value),
    );
  }
}
