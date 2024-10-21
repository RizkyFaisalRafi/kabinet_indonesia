import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import 'package:kabinet_indonesia/view/login_screen.dart';
import '../constants/app_colors.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membuat statusBar Transparan
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    final pageDecoration = PageDecoration(
      titleTextStyle: fontJakartaSans.copyWith(
        fontWeight: bold,
        fontSize: fontExtraLarge,
      ),
      bodyTextStyle: fontJakartaSans.copyWith(
        fontWeight: medium,
        fontSize: fontLarge,
      ),
      bodyPadding: const EdgeInsets.all(20),
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.grey[10],
      pages: [
        // Screen 1
        PageViewModel(
          titleWidget: Text(
            'Indonesia Emas 2045',
            style: fontJakartaSans.copyWith(
              fontWeight: bold,
              fontSize: fontExtraLarge,
            ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            'Bersama kita wujudkan Indonesia yang lebih maju dan sejahtera melalui inovasi, kolaborasi, dan semangat gotong royong.',
            style: fontJakartaSans.copyWith(
              fontWeight: medium,
              fontSize: fontMedium,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.asset(
            'assets/images/indonesia_emas.png',
            width: 350,
            fit: BoxFit.fill,
            height: 200,
          ),
          decoration: pageDecoration,
        ),

        // Screen 2
        PageViewModel(
          titleWidget: Text(
            'Kabinet Indonesia Maju',
            style: fontJakartaSans.copyWith(
              fontWeight: bold,
              fontSize: fontExtraLarge,
            ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            'Kami percaya bahwa melalui kerja sama, kita dapat mewujudkan masa depan Indonesia yang lebih cerah dan berdaya saing global.',
            style: fontJakartaSans.copyWith(
              fontWeight: medium,
              fontSize: fontMedium,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.asset(
            'assets/images/image.png',
            width: 350,
            fit: BoxFit.fill,
            height: 200,
          ),
          decoration: pageDecoration,
        ),

        // Screen 3
        PageViewModel(
          titleWidget: Text(
            'Sekretariat Kabinet RI',
            style: fontJakartaSans.copyWith(
              fontWeight: bold,
              fontSize: fontExtraLarge,
            ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            'Informasi - informasi Kabinet negara republik indonesia kini berada di genggaman aplikasi dengan akses yang mudah.',
            style: fontJakartaSans.copyWith(
              fontWeight: medium,
              fontSize: fontMedium,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.asset(
            'assets/images/sekretariat_kabinet.png',
            width: 350,
            fit: BoxFit.fill,
            height: 200,
          ),
          decoration: pageDecoration.copyWith(
            imageFlex: 1,
            footerFlex: 0,
            safeArea: 0,
          ),
          footer: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(
                'Lanjut',
                style: fontJakartaSans.copyWith(
                  color: AppColors.white,
                  fontWeight: semiBold,
                  fontSize: fontMedium,
                ),
              ),
            ),
          ),
        ),
      ],
      showSkipButton: true,
      showNextButton: true,
      showDoneButton: false,
      showBackButton: false,
      skip: const Icon(
        Icons.done_outline_rounded,
        color: Colors.black,
      ),
      next: const Icon(
        Icons.arrow_circle_right,
        color: Colors.black,
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10, 10),
        color: Colors.grey,
        activeColor: Colors.amber,
        activeSize: Size(20, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
