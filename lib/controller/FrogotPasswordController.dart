import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      errorMessage = "Please enter your email.";
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      errorMessage = "Password reset link sent to your email.";
      notifyListeners();

      // Optional: Show a success message or navigate back to the login page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );

      // Clear the email input after sending
      emailController.clear();
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? "An error occurred. Please try again.";
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
