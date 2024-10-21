import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/view_model/register_provider.dart';

import '../model/users_data.dart';

class GetDataProvider extends ChangeNotifier {
  // GET DATA
  String? _uid;
  UsersData? usersData;

  Future<void> getData() async {
    User? user = RegisterProvider().currentUser;
    _uid = user?.uid;

    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    notifyListeners();
    usersData = UsersData(
      uid: snapshot.get('uid'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      address: snapshot.get('address'),
      numberPhone: snapshot.get('numberPhone'),
    );
  }
}
