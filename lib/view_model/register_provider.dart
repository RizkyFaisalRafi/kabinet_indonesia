import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/login_screen.dart';

class RegisterProvider extends ChangeNotifier {
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool? emailVerified;
  User? get currentUser => firebaseAuth.currentUser;
  bool isLoading = false;

  // Instance Firebase Auth & Firestore
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Controller with Getter
  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  final _numberPhoneController = TextEditingController();
  TextEditingController get numberPhoneController => _numberPhoneController;
  final _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;
  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final _passController = TextEditingController();
  TextEditingController get passController => _passController;
  final _repeatPassController = TextEditingController();
  TextEditingController get repeatPassController => _repeatPassController;

  // Validator Name
  String? validateName(name) {
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    } else if (name.split('').length < 2) {
      return 'Nama harus terdiri dari minimal 2 kata!';
    } else {
      return null;
    }
  }

  // Validator Number Telephone
  String? validateNumberPhone(String numberPhone) {
    if (numberPhone.isEmpty) {
      return 'Nomor Telephone tidak boleh kosong!';
    } else if (numberPhone.split('').length < 2) {
      return 'Nomor Telephone harus terdiri dari minimal 2 kata!';
    } else {
      return null;
    }
  }

  // Validator Alamat
  String? validateAddress(alamat) {
    if (alamat.isEmpty) {
      return "Alamat tidak boleh kosong!";
    } else {
      return null;
    }
  }

  // Validator Email
  String? validateEmail(email) {
    if (email.isEmpty) {
      return "Email tidak boleh kosong!";
    } else if (email.contains(RegExp(r'[!#<>?":$_`~;[\]\\|=+)(*&^%-]'))) {
      return 'Email tidak boleh mengandung karakter khusus!';
    } else {
      return null;
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

// Validator Ulangi Kata Sandi
  String? validatePassRepeat(passRepeat) {
    if (passRepeat.isEmpty) {
      return "Ulangi Kata Sandi tidak boleh kosong!";
    } else if (passRepeat.length < 8) {
      return 'Ulangi Kata Sandi harus terdiri dari minimal 8 karakter!';
    } else if (passRepeat != passController.text) {
      return 'Ulangi Kata Sandi tidak sama dengan Kata Sandi!';
    } else {
      return null;
    }
  }

  // Show Password
  void toggleObscureText1() {
    notifyListeners();
    obscureText1 = !obscureText1;
  }

  void toggleObscureText2() {
    notifyListeners();
    obscureText2 = !obscureText2;
  }

  // Register Firebase Auth & Firestore
  Future<void> authenticateRegister(BuildContext context) async {
    isLoading = true;
    UserCredential userCredential;
    notifyListeners();

    try {
      notifyListeners();

      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      // Pengecekan bahwa firebase auth sukses maka lakukan daftar
      if (userCredential.user != null) {
        notifyListeners();
        // Send Data To Firestore

        firebaseFirestore
            .collection("users")
            .doc(userCredential.user?.uid)
            .set({
          "uid": userCredential.user!.uid,
          "name": nameController.text,
          "numberPhone": numberPhoneController.text,
          "address": addressController.text,
          "email": emailController.text,
          "password": passController.text,
        });

        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ));

          nameController.clear();
          numberPhoneController.clear();
          addressController.clear();
          emailController.clear();
          passController.clear();
          repeatPassController.clear();

          // Menampilkan pesan sukses
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registrasi berhasil! Silakan login.'),
              backgroundColor: Colors.green,
            ),
          );
          await firebaseAuth.signOut();
        }
      } else {
        notifyListeners();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registrasi gagal! Silakan coba lagi.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      notifyListeners();
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

  // Logout from Firebase Account
  Future<void> logOut(BuildContext context) async {
    try {
      notifyListeners();
      await firebaseAuth.signOut();
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Keluar Akun'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    numberPhoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    passController.dispose();
    repeatPassController.dispose();
    super.dispose();
  }
}
