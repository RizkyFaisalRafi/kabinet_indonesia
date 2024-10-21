import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/components/buttons.dart';
import 'package:kabinet_indonesia/components/list_profile.dart';
import 'package:kabinet_indonesia/components/spaces.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import 'package:kabinet_indonesia/view/about_app_page.dart';
import 'package:kabinet_indonesia/view/contact_us_screen.dart';
import 'package:kabinet_indonesia/view/edit_profile_screen.dart';
import 'package:kabinet_indonesia/view/theme_app_page.dart';
import 'package:kabinet_indonesia/view_model/get_data_provider.dart';
import 'package:kabinet_indonesia/view_model/register_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final providerGetData = context.read<GetDataProvider>();
    providerGetData.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              businessCard(),
              const SpaceHeight(20),
              ListProfile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfileScreen();
                      },
                    ),
                  );
                },
                imagePath: 'assets/icons/profile_profil.svg',
                title: 'Akun',
                subTitle: 'Edit Profile',
              ),
              const SpaceHeight(8),
              ListProfile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ThemeAppPage();
                      },
                    ),
                  );
                },
                imagePath: 'assets/icons/settings_profil.svg',
                title: 'Pengaturan',
                subTitle: 'Pengaturan tentang aplikasi.',
              ),
              const SpaceHeight(8),
              ListProfile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ContactUsScreen();
                      },
                    ),
                  );
                },
                imagePath: 'assets/icons/contact_us_profil.svg',
                title: 'Hubungi Kami',
                subTitle: 'Sampaikan kendala, kritik, dan saran Anda.',
              ),
              const SpaceHeight(8),
              ListProfile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AboutAppPage();
                      },
                    ),
                  );
                },
                imagePath: 'assets/icons/about_app_profil.svg',
                title: 'Tentang Aplikasi',
                subTitle: 'Lihat informasi lengkap tentang aplikasi.',
              ),

              // Button LogOut
              const SpaceHeight(100),
              Consumer<RegisterProvider>(builder: (context, provider, _) {
                return Button.filled(
                  onPressed: () {
                    provider.logOut(context);
                  },
                  label: 'Keluar',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget businessCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<GetDataProvider>(builder: (context, data, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.usersData?.name ?? 'Null',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    data.usersData?.email ?? 'Null',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    data.usersData?.address ?? 'Null',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    data.usersData?.numberPhone ?? 'Null',
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
