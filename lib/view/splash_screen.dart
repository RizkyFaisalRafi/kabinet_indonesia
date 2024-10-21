import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/constants/app_colors.dart';
import 'package:kabinet_indonesia/components/spaces.dart';
import 'package:kabinet_indonesia/view/bottom_nav.dart';
import 'package:kabinet_indonesia/view/login_screen.dart';
import 'package:kabinet_indonesia/view/on_boarding_screen.dart';
import 'package:kabinet_indonesia/constants/theme.dart';

import '../data/onboarding_local_datasource.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        log('introduction: $introduction');

        // Cek apakah pengguna sudah login menggunakan FirebaseAuth
        User? user = FirebaseAuth.instance.currentUser;

        // kondisi jika aplikasi pertama kali dibuka
        if (introduction == 0) {
          if (context.mounted) {
            return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const OnBoardingScreen();
                },
              ),
            );
          }
        } else if (user != null) {
          // Jika pengguna sudah login, arahkan ke HomeScreen
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const BottomNav(); // Arahkan ke HomeScreen BottomNav
                },
              ),
            );
          }
        } else {
          if (context.mounted) {
            return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          }
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SpaceHeight(20),
            Text(
              'https://setkab.go.id/profil-kabinet/',
              style: fontPacifico.copyWith(
                fontSize: fontLarge,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Powered by Rizky Faisal Rafi',
          style: fontPacifico.copyWith(
            color: AppColors.black,
            fontWeight: semiBold,
            fontSize: fontMedium,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
