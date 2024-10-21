import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import '../components/spaces.dart';
import '../constants/app_colors.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image Logo
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),

                  const SpaceHeight(8),

                  // Name App
                  Text(
                    'Kabinet Indonesia',
                    style: fontJakartaSans.copyWith(
                      color: AppColors.white,
                      fontWeight: bold,
                      fontSize: fontExtra,
                    ),
                  ),

                  const SpaceHeight(22),
                ],
              ),
            ),

            // Description App
            Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Versi App
                  Text(
                    'Aplikasi versi 1.0.0 - Kabinet Indonesia',
                    style: fontJakartaSans.copyWith(
                      fontWeight: bold,
                      fontSize: fontMedium,
                    ),
                  ),

                  const SpaceHeight(12),

                  // Description App
                  Text(
                    'Kabinet Indonesia merupakan aplikasi informasi tentang kabinet - kabinet yang ada di indonesia yang bersumber dari website (https://setkab.go.id/profil-kabinet/) sebagai syarat lulus di kelas Flutter Pemula untuk perbarui sertifikat Dicoding  X IdCamp.',
                    style: fontJakartaSans.copyWith(
                      fontWeight: reguler,
                      fontSize: fontMedium,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SpaceHeight(20),

                  // Information Prroblem
                  Text(
                    'Apabila menemukan kendala dalam penggunaan aplikasi. Silahkan menuju ke menu Hubungi Kami.',
                    style: fontJakartaSans.copyWith(
                      fontWeight: bold,
                      fontSize: fontMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
