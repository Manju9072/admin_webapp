import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'resolution_option.dart';

class ImageHandlingWidget extends StatefulWidget {
  final Function(List<String>, List<String>) onImagesSelected;

  const ImageHandlingWidget({required this.onImagesSelected, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageHandlingWidgetState createState() => _ImageHandlingWidgetState();
}

class _ImageHandlingWidgetState extends State<ImageHandlingWidget> {
  // final List<String> _imagePreviews = [];
  final List<String> _imageDescriptions = [];
  final List<bool> _isEditingList = []; // List to track editing state
  final List<ResolutionOption> resolutionOptions = [
    ResolutionOption('Low (480x320)', 480, 320),
    ResolutionOption('Medium (800x600)', 800, 600),
    ResolutionOption('High (1200x900)', 1200, 900),
  ];
  ResolutionOption _selectedResolution =
      ResolutionOption('Medium (800x600)', 800, 600);
  bool _isMultipleSelection = false;
  final TextEditingController _imageDescriptionController =
      TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  final List<Map<String, dynamic>> _imagePreviews = [];

  Future<void> _pickImage() async {
    if (_imageDescriptionController.text.isEmpty) {
      _showDescriptionError();
      return;
    }

    if (_isMultipleSelection) {
      final pickedImages = await _pickMultipleImages();
      final imageDescriptions = List.generate(pickedImages.length, (index) {
        return {
          'imagePath': pickedImages[index],
          'description': _imageDescriptionController.text,
        };
      });

      print('Length of pickedImages: ${pickedImages.length}');
      print('Length of imageDescriptions: ${imageDescriptions.length}');

      setState(() {
        _imagePreviews.addAll(imageDescriptions);
        _isEditingList
            .addAll(List.generate(pickedImages.length, (index) => false));
      });

      print('Final _imagePreviews: $_imagePreviews');

      widget.onImagesSelected(
        List<String>.from(_imagePreviews.map((map) => map['imagePath'])),
        List<String>.from(_imagePreviews.map((map) => map['description'])),
      );
    } else {
      setState(() {
        _imagePreviews.clear();
        _isEditingList.clear();
      });

      final pickedImage = await _pickSingleImage();
      if (pickedImage != null) {
        final imageDescription = _imageDescriptionController.text;
        setState(() {
          _imagePreviews.add({
            'imagePath': pickedImage,
            'description': imageDescription,
          });
          _isEditingList.add(false);
        });

        _imageDescriptionController.clear();

        widget.onImagesSelected([pickedImage], [imageDescription]);
      }
    }
  }

  Future<List<String>> _pickMultipleImages() async {
    List<String> pickedImages = [];

    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage();

      pickedImages = pickedFiles.map((pickedFile) => pickedFile.path).toList();
    } else {
      if (kDebugMode) {
        print('Image picking not supported on this platform.');
      }
    }

    return pickedImages;
  }

  Future<String?> _pickSingleImage() async {
    String? imagePath;

    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagePath = pickedFile.path;
      }
    } else {
      if (kDebugMode) {
        print('Image picking not supported on this platform.');
      }
    }

    return imagePath;
  }

  void _showOriginalImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  void _showResizedImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: _selectedResolution.width.toDouble(),
            height: _selectedResolution.height.toDouble(),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  void _showFullImage(dynamic imageUrl, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Display Option:'),
              ListTile(
                title: const Text('Original'),
                onTap: () {
                  Navigator.pop(context);
                  _showOriginalImage(imageUrl);
                },
              ),
              ListTile(
                title: const Text('With Resolution'),
                onTap: () {
                  Navigator.pop(context);
                  _showResizedImage(imageUrl);
                },
              ),
              ListTile(
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _editImageDescription(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResolutionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Resolution'),
          content: Column(
            children: resolutionOptions
                .map(
                  (option) => ListTile(
                    title: Text(option.label),
                    onTap: () {
                      setState(() {
                        _selectedResolution = option;
                      });
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void _showDescriptionError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Description Error'),
          content: const Text('Please enter a description before uploading.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _editImageDescription(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Image Description'),
          content: Column(
            children: [
              TextField(
                controller: _descriptionEditingController,
                decoration: const InputDecoration(
                  labelText: 'Image Description',
                  hintText: 'Enter a new description for the image',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _imageDescriptions[index] =
                            _descriptionEditingController.text;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int co = 0;
    print("--------Image hand Build------");
    print(co++);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Multiple Image Selection'),
                Switch(
                  value: _isMultipleSelection,
                  onChanged: (value) {
                    setState(() {
                      _isMultipleSelection = value;
                      _imagePreviews.clear();
                      _imageDescriptions.clear();
                      _isEditingList.clear();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _showResolutionDialog,
              child: const Text('Select Image Resolution'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _imageDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Image Description',
                  hintText: 'Enter a description for the image',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            if (_imagePreviews.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _imagePreviews.asMap().entries.map((entry) {
                    final index = entry.key;
                    final imageUrl = entry.value;

                    return GestureDetector(
                      onTap: () => _showFullImage(imageUrl, index),
                      child: Column(
                        children: [
                          Image.network(
                            imageUrl['imagePath'] as String,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _imageDescriptions.length > index
                                      ? _imageDescriptions[index]
                                      : '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              IconButton(
                                icon: _isEditingList[index]
                                    ? const Icon(Icons.save)
                                    : const Icon(Icons.edit),
                                onPressed: () {
                                  if (_isEditingList[index]) {
                                    setState(() {
                                      _imageDescriptions[index] =
                                          _descriptionEditingController.text;
                                      _isEditingList[index] = false;
                                    });
                                  } else {
                                    setState(() {
                                      _descriptionEditingController.text =
                                          _imageDescriptions[index];
                                      _isEditingList[index] = true;
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _imagePreviews.removeAt(index);
                                    _imageDescriptions.removeAt(index);
                                    _isEditingList.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
