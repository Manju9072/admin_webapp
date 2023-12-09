import 'package:flutter/material.dart';

class WidgetInfo {
  final Widget widget;
  final WidgetType type;
  final int number;

  WidgetInfo({required this.widget, required this.type, this.number = 0});
}

// Enum to represent the type of widget
enum WidgetType {
  Text,
  Image,
  SEOForm,
}

class WidgetContainer extends StatelessWidget {
  final Widget widget;
  final int number;
  final VoidCallback onRemove;

  const WidgetContainer({
    required this.widget,
    required this.number,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text('Widget $number',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        widget,
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: onRemove,
          child: const Text('Remove Widget'),
        ),
      ],
    );
  }
}
