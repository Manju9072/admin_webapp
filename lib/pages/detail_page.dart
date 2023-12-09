// import 'dart:io' show Platform;

import 'package:admin_webapp/pages/type/research_arti.dart';
import 'package:admin_webapp/pages/type/write_up.dart';
// import 'package:admin_webapp/resolution_option.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class DetailPage extends StatefulWidget {
  final String pageTitle;

  const DetailPage(this.pageTitle, {super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _headerController = TextEditingController();
  // final TextEditingController _contentController = TextEditingController();
  // String _imagePreview = ''; // Store the image path or URL
  // final List<ResolutionOption> resolutionOptions = [
  //   ResolutionOption('Low (480x320)', 480, 320),
  //   ResolutionOption('Medium (800x600)', 800, 600),
  //   ResolutionOption('High (1200x900)', 1200, 900),
  // ];
  // ResolutionOption _selectedResolution =
  //     ResolutionOption('Medium (800x600)', 800, 600);

  // Future<void> _pickImage() async {
  //   if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
  //     final picker = ImagePicker();
  //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       setState(() {
  //         _imagePreview = pickedFile.path;
  //       });
  //     }
  //   } else {
  //     // Handle image picking for other platforms (if needed)
  //     // On other platforms, you might want to use a different method or show an error message
  //     if (kDebugMode) {
  //       print('Image picking not supported on this platform.');
  //     }
  //   }
  // }

  // void _showResolutionDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Select Image Resolution'),
  //         content: Column(
  //           children: resolutionOptions
  //               .map(
  //                 (option) => ListTile(
  //                   title: Text(option.label),
  //                   onTap: () {
  //                     setState(() {
  //                       _selectedResolution = option;
  //                     });
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showFullImage() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text('Select Display Option:'),
  //             ListTile(
  //               title: const Text('Original'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _showOriginalImage();
  //               },
  //             ),
  //             ListTile(
  //               title: const Text('With Resolution'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _showResizedImage();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showOriginalImage() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Image.network(
  //           _imagePreview,
  //           fit: BoxFit.contain,
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showResizedImage() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: SizedBox(
  //           width: _selectedResolution.width.toDouble(),
  //           height: _selectedResolution.height.toDouble(),
  //           child: Image.network(
  //             _imagePreview,
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Widget pageWidget;

    switch (widget.pageTitle) {
      case 'Research Article':
        pageWidget = const ResearchArti();
        break;
      case 'Write Up':
        pageWidget = const WriteUp();
        break;
      case 'Review Article':
        pageWidget = const ResearchArti();
        break;
      case 'Photo Gallery Article':
        pageWidget = const ResearchArti();
        break;
      case 'Episod magizine Article':
        pageWidget = const ResearchArti();
        break;
      case 'Page 6':
        pageWidget = const ResearchArti();
        break;
      default:
        pageWidget = const ResearchArti();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: pageWidget,
    );
  }
}
