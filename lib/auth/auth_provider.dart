// auth_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'authentication_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticationService _authenticationService;

  AuthProvider(this._authenticationService);

  bool get isUserSignedIn => _authenticationService.isUserSignedIn();

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      print('User registered: ${user.uid}');
    } catch (e) {
      print('Error registering user: $e');
      // Handle error (display error message, etc.)
    }
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    email = "varateblog@gmail.com";
    password = "Password@321";
    final error = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    if (error == null) {
      notifyListeners(); // Notify listeners on successful sign-in
    }
    return error;
  }

  Future<void> signOut() async {
    await _authenticationService.signOut();
    notifyListeners(); // Notify listeners on sign-out
  }
}
