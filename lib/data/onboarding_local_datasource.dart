// Handle status apakah halaman OnBoarding sudah terbuka atau belum
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart'; // Library untuk mengakses Shared Preferences

int introduction = 0; // Default 0 = Belum terbuka sama sekali

class OnboardingLocalDatasource {
  // Fungsi untuk menginisialisasi status Onboarding
  Future initIntroduction() async {
    // Mengambil instance dari SharedPreferences
    final preferences = await SharedPreferences.getInstance();

    // Mengambil nilai 'introduction' dari SharedPreferences
    int? intro = preferences.getInt('introduction');
    log('intro: $intro'); // Menampilkan nilai intro di konsol untuk debugging

    // Cek apakah Onboarding sudah dibuka
    if (intro != null && intro == 1) {
      // Jika sudah dibuka, set nilai introduction menjadi 1
      return introduction = 1;
    }

    // Jika baru dibuka, set nilai 'introduction' di SharedPreferences menjadi 1
    await preferences.setInt('introduction', 1);
  }
}
