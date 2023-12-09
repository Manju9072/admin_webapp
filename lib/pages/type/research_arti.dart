import 'package:admin_webapp/tools/image_handling_widget.dart';
import 'package:flutter/material.dart';

class ResearchArti extends StatefulWidget {
  const ResearchArti({super.key});

  @override
  State<ResearchArti> createState() => _ResearchArtiState();
}

class _ResearchArtiState extends State<ResearchArti> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                  labelText: 'Title (up to 50 characters)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _headerController,
              maxLength: 300,
              maxLines: null, // Allow multiple lines
              decoration: const InputDecoration(
                  labelText: 'Header (up to 300 characters)'),
            ),
            const SizedBox(height: 16),
            ImageHandlingWidget(
              onImagesSelected: (imagePaths, imageDescriptions) {
                // Handle the selected image paths as needed
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: null, // Allow multiple lines
              decoration: const InputDecoration(labelText: 'Main Content'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your logic to save the details
                // You can access the entered values using _titleController.text, _headerController.text, _contentController.text
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
