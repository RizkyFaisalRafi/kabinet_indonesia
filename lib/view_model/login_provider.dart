import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/view/bottom_nav.dart';

class LoginProvider extends ChangeNotifier {
  bool obscureText = true;
  UserCredential? userCredential;
  bool isLoading = false;

  // Email Pass Controller with Getter
  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final _passController = TextEditingController();
  TextEditingController get passController => _passController;

  // Show Password
  void toggleObscureText() {
    notifyListeners();
    obscureText = !obscureText;
  }

  // Validator Email
  String? validateEmail(email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (email.isEmpty) {
      return "Email tidak boleh kosong!";
    } else if (!emailRegex.hasMatch(email)) {
      return 'Format email tidak valid!';
    } else if (email.contains(RegExp(r'[!#<>?":$_`~;[\]\\|=+)(*&^%-]'))) {
      return 'Email tidak boleh mengandung karakter khusus!';
    } else {
      return null; // Email valid
    }
  }

  // Validator Password
  String? validatePass(pass) {
    if (pass.isEmpty) {
      return "Password tidak boleh kosong!";
    } else if (pass.split('').length < 8) {
      return 'Password harus terdiri dari minimal 8 kata!';
    } else {
      return null;
    }
  }

  // Instance Firebase Auth & Firestore
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Login Firebase Auth & Firestore
  Future<void> authenticateLogin(BuildContext context) async {
    UserCredential userCredential;
    isLoading = true;
    notifyListeners();
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      log(userCredential.user!.displayName ?? 'Null Bro');

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const BottomNav();
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Masuk, Selamat Datang!'),
            backgroundColor: Colors.green,
          ),
        );
      }
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.code),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
