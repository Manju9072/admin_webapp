// login_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Call the signInWithEmailAndPassword method from AuthProvider
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    final error = await authProvider.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                    print(_emailController.text);

                    // Handle the result, e.g., show an error message
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Sign in'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    final error =
                        await authProvider.registerWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text('Sign Up'), // Corrected the button text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
