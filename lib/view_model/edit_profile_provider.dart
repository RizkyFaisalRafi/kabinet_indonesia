import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/view/bottom_nav.dart';

class EditProfileProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final addressController = TextEditingController();
  final name = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<void> updateProfile(BuildContext context) async {
    try {
      // Firestore Update Operation
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await firestore.collection('users').doc(userId).update({
        'name': nameController.text,
        'address': addressController.text,
        'numberPhone': numberPhoneController.text,
      });
      if (context.mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil berhasil diperbarui di Firestore!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const BottomNav();
            },
          ),
        );
      }
    } catch (e) {
      // Show error message if firestore update fails
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui profil: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
