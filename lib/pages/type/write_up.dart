// lib/pages/type/write_up.dart
import 'package:admin_webapp/data/article.dart';
import 'package:admin_webapp/tools/dynamic_widget.dart';
import 'package:admin_webapp/tools/image_handling_widget.dart';
import 'package:admin_webapp/tools/seo_form.dart';
import 'package:flutter/material.dart';

class WriteUp extends StatefulWidget {
  const WriteUp({Key? key}) : super(key: key);

  @override
  State<WriteUp> createState() => _WriteUpState();
}

class _WriteUpState extends State<WriteUp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, dynamic>> dynamicWidgetData = [];

  List<String> imagePaths = [];
  List<String> imageDescriptions = [];
  List<String> dropdownOptions = [
    'Research Article',
    'Write Up',
    'Review Article',
    'Photo Gallery Article',
    'Episod magazine Article',
    'Page 6'
  ];
  String selectedOption = 'Research Article'; // Default selected option
  Map<String, String> seoData = {
    'metaDescription': '',
    'headerTags': '',
    'urlStructure': '',
    'imageAltText': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Align the dropdown to the left
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(72.0, 0, 0, 8.0),
                child: DropdownButton<String>(
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedOption = newValue;
                      });
                    }
                  },
                  items: dropdownOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Title (up to 50 characters)',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                maxLines: null, // Allow multiple lines
                decoration: const InputDecoration(labelText: 'Main Content'),
              ),
              const SizedBox(height: 16),
              ImageHandlingWidget(
                onImagesSelected: (previews, descriptions) {
                  setState(() {
                    imagePaths = previews;
                    imageDescriptions = descriptions;
                  });
                },
              ),
              const SizedBox(height: 16),
              DynamicWidget(
                onSave: (data) {
                  setState(() {
                    dynamicWidgetData = data;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Save data to the backend
                  Article article =
                      createArticle(); // Create an Article instance

                  // Print the article data (for testing purposes)
                  print('Article Type: ${article.articleType}');
                  print('Title: ${article.title}');
                  print('Content: ${article.content}');
                  print('Main Image: ${article.mainImage}');
                  print('Additional Images: ${article.additionalImages}');
                  print('Additional Texts: ${article.additionalTexts}');
                  print('SEO Data: ${article.seoData}');
                  print('Header Data: ${article.headerData}');

                  // You can now send the 'article' object to your backend API or perform other operations
                  // Example: sendArticleToBackend(article);

                  // Add your logic to send the data to the backend API (MongoDB)
                  // Example: sendToBackend(article);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveData() {
    // Access the captured data and send it to the backend API or perform other operations
    print('Article type: $selectedOption');
    print('Title: ${_titleController.text}');
    print('Main Content: ${_contentController.text}');
    print('Image Paths: $imagePaths');
    print('Image Descriptions: $imageDescriptions');

    // Add your logic to send the data to the backend API (MongoDB)
    // You can use a network library like Dio or http to make API requests
    // Example: sendToBackend(selectedOption, _titleController.text, _contentController.text, imagePaths, imageDescriptions);
  }

  // Function to create an Article instance from the current state of the page
  Article createArticle() {
    return Article(
      articleType: selectedOption,
      title: _titleController.text,
      content: _contentController.text,
      mainImage: createMainImageList(),
      additionalImages: createAdditionalImagesList(),
      // ... additional fields
    );
  }

  List<Map<String, String>> createMainImageList() {
    List<Map<String, String>> mainImageList = [];
    for (int i = 0; i < imagePaths.length; i++) {
      mainImageList.add({
        'imagePath': imagePaths[i],
        'description': imageDescriptions.length > i ? imageDescriptions[i] : '',
      });
    }
    return mainImageList;
  }

  // Function to create a list of additional images from the current state of the page
  List<Map<String, String>> createAdditionalImagesList() {
    List<Map<String, String>> imagesList = [];

    for (int i = 0; i < imagePaths.length; i++) {
      imagesList.add({
        'imagePath': imagePaths[i],
        'description': imageDescriptions.length > i ? imageDescriptions[i] : '',
      });
    }

    return imagesList;
  }
}
