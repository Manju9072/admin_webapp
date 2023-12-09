// seo_form.dart
import 'package:flutter/material.dart';

class SEOForm extends StatefulWidget {
  final Function(String, String, String, String) onSave;

  const SEOForm({Key? key, required this.onSave}) : super(key: key);

  @override
  _SEOFormState createState() => _SEOFormState();
}

class _SEOFormState extends State<SEOForm> {
  final TextEditingController _metaDescriptionController =
      TextEditingController();
  final TextEditingController _headerTagsController = TextEditingController();
  final TextEditingController _urlStructureController = TextEditingController();
  final TextEditingController _imageAltTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _metaDescriptionController,
              decoration: const InputDecoration(labelText: 'Meta Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _headerTagsController,
              decoration: const InputDecoration(labelText: 'Header Tags'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlStructureController,
              decoration: const InputDecoration(labelText: 'URL Structure'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imageAltTextController,
              decoration: const InputDecoration(labelText: 'Image Alt Text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Pass the SEO data back to the callback function
                widget.onSave(
                  _metaDescriptionController.text,
                  _headerTagsController.text,
                  _urlStructureController.text,
                  _imageAltTextController.text,
                );

                // Optionally, you can navigate back or close the form
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
