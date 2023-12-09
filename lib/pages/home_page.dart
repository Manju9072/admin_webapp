// lib/pages/home_page.dart
import 'package:admin_webapp/pages/type/write_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_provider.dart';

class HomePage extends StatelessWidget {
  final List<String> gridOptions = ['Add Article', 'View Artical'];

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold) // Set the text color
                ),
            onPressed: () {
              // Call the signOut method from AuthProvider
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              authProvider.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: gridOptions.map((option) {
          Color? buttonColor = option == 'View Artical'
              ? const Color(0xff00b1d2)
              : const Color(0xffFDDB27);
          return Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the DetailPage with the selected option
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      if (option == 'Add Article') {
                        return const WriteUp(); // Navigate to the WriteUp page for adding articles
                      } else if (option == 'View Artical') {
                        return const WriteUp(); // Navigate to the ResearchPage for viewing articles
                      } else {
                        // Handle other options or show an error page
                        return Container(); // Replace with your error or default page
                      }
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                padding: const EdgeInsets.all(16.0),
                backgroundColor: buttonColor,
                textStyle: const TextStyle(
                    fontSize: 18), // Set background color for "View" button
              ),
              child: Text(option,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
