import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/spaces.dart';
import '../constants/theme.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hubungi Kami',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deskripsi Keluhan
            Text(
              'Untuk keluhan, kritik, dan saran dalam penggunaan aplikasi Kabinet Indonesia, Anda dapat menghubungi:',
              style: fontJakartaSans.copyWith(
                fontSize: fontMedium,
              ),
            ),

            const SpaceHeight(8),

            // Card Number WhatsApp
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                launchWhatsApp();
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    '0895 4128 92094',
                    style: fontJakartaSans.copyWith(
                      fontSize: fontMedium,
                    ),
                  ),
                  leading:
                      SvgPicture.asset('assets/icons/contact_us_profil.svg'),
                ),
              ),
            ),

            const SpaceHeight(4),

            // Card Email
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () async {
                launchEmail();
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    'rizkyfaisalrafi123@gmail.com',
                    style: fontJakartaSans.copyWith(
                      fontSize: fontMedium,
                    ),
                  ),
                  leading: SvgPicture.asset('assets/icons/email_icon.svg'),
                ),
              ),
            ),

            const SpaceHeight(8),

            // Deskripsi Jam Kerja
            Text(
              'Hubungi kami pada saat jam kerja:\n09:00 - 16:00 WIB',
              style: fontJakartaSans.copyWith(
                fontSize: fontMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function launch WA
  void launchWhatsApp() async {
    String url = "wa.me/62895412892094";
    final Uri whatsappUrl = Uri(scheme: 'https', path: url);

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  // Function launch PhoneNumber
  void launchPhone() async {
    final Uri url = Uri(scheme: 'tel', path: "0895412892094");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function launch Email
  void launchEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'rizkyfaisalrafi123@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Send your Subject',
        'body': 'Your Description',
      }),
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
