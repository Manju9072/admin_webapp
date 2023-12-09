import 'package:admin_webapp/tools/heade_text_input.dart';
import 'package:admin_webapp/tools/image_handling_widget.dart';
import 'package:admin_webapp/tools/seo_form.dart';
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
  final VoidCallback onRemove;

  const WidgetContainer({
    required this.widget,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("--------Widget container Build------");

    return Column(
      children: [
        const SizedBox(height: 16),
        const Text('Widget', style: TextStyle(fontWeight: FontWeight.bold)),
        widget,
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: onRemove,
          child: const Text('Remove Widget'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

// tools/dynamic_widget.dart

class DynamicWidget extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onSave;

  const DynamicWidget({Key? key, required this.onSave}) : super(key: key);

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  List<Map<String, dynamic>> dynamicWidgetData = [];
  bool isAddSEOButtonDisabled = false;

  void addImageHandler() {
    setState(() {
      dynamicWidgetData.add({
        'type': 'image',
        'data': {'imagePath': '', 'description': ''}
      });
    });
  }

  void addTextInput() {
    setState(() {
      dynamicWidgetData.add({'type': 'text', 'data': {}});
      print("Text Data Added: $dynamicWidgetData"); // Add this line
      dynamicWidgetData.forEach((data) {
        print("Data: $data");
      });
      widget.onSave(dynamicWidgetData); // Save immediately after adding
    });
  }

  void addSEOHandler() {
    setState(() {
      isAddSEOButtonDisabled = true;
      dynamicWidgetData.add({'type': 'seo', 'data': {}});
    });
  }

  void addHeaderHandler() {
    setState(() {
      dynamicWidgetData.add({'type': 'header', 'data': {}});
      widget.onSave(dynamicWidgetData); // Save immediately after adding
    });
  }

  void removeWidget(int index) {
    setState(() {
      var l = dynamicWidgetData.removeAt(index);
      if (l['type'] == 'seo') {
        enableSEOButton();
      }
    });
  }

  void enableSEOButton() {
    setState(() {
      isAddSEOButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("DynamicWidget Rebuilt");
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: List.generate(dynamicWidgetData.length, (index) {
              Map<String, dynamic> widgetData = dynamicWidgetData[index];
              Widget widget = getWidgetFromType(widgetData['type'], index);
              return WidgetContainer(
                widget: widget,
                onRemove: () => removeWidget(index),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: addImageHandler,
                child: const Text('Add Image'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: addTextInput,
                child: const Text('Add content/Para'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: isAddSEOButtonDisabled ? null : addSEOHandler,
                child: const Text('Add SEO Data'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: addHeaderHandler,
                child: const Text('Add Header'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     widget.onSave(dynamicWidgetData);
          //   },
          //   child: const Text('Save Dynamic Widgets'),
          // ),
        ],
      ),
    );
  }

  Widget getWidgetFromType(String type, int index) {
    switch (type) {
      case 'image':
        return ImageHandlingWidget(
          onImagesSelected: (previews, descriptions) {
            setState(() {
              dynamicWidgetData[index]['data'] = {
                'imagePath': previews.isNotEmpty ? previews[index] : '',
                'description':
                    descriptions.isNotEmpty ? descriptions[index] : '',
              };
              print(dynamicWidgetData);
              widget.onSave(dynamicWidgetData);
            });
          },
        );
      case 'text':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Enter Text',
            ),
            onChanged: (text) {
              setState(() {
                dynamicWidgetData[index]['data'] = {'text': text};
                widget.onSave(dynamicWidgetData);
              });
            },
          ),
        );
      case 'seo':
        return SEOForm(
          onSave: (metaDescription, headerTags, urlStructure, imageAltText) {
            setState(() {
              dynamicWidgetData[index]['data'] = {
                'metaDescription': metaDescription,
                'headerTags': headerTags,
                'urlStructure': urlStructure,
                'imageAltText': imageAltText,
              };
              widget.onSave(dynamicWidgetData);
            });
          },
        );
      case 'header':
        return HeaderInputWidget(
          onSave: (text, level) {
            setState(() {
              dynamicWidgetData[index]['data'] = {'text': text, 'level': level};
              widget.onSave(dynamicWidgetData);
            });
          },
        );
      default:
        throw Exception('Invalid widget type');
    }
  }
}
