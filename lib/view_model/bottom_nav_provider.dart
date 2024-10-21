import 'package:flutter/material.dart';

import '../view/home_screen.dart';
import '../view/profile_screen.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
