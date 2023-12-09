// tools/header_input_widget.dart
import 'package:flutter/material.dart';

class HeaderInputWidget extends StatelessWidget {
  final Function(String, int) onSave;

  const HeaderInputWidget({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedLevel = 1;
    final TextEditingController _textController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<int>(
            value: selectedLevel,
            onChanged: (int? newValue) {
              if (newValue != null) {
                selectedLevel = newValue;
              }
            },
            items: [1, 2, 3, 4, 5, 6].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('H$value'),
              );
            }).toList(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Header Text'),
              onChanged: (text) {
                onSave(text, selectedLevel);
              },
            ),
          ),
        ],
      ),
    );
  }
}
