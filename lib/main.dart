import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/view/splash_screen.dart';
import 'package:kabinet_indonesia/view_model/bottom_nav_provider.dart';
import 'package:kabinet_indonesia/view_model/edit_profile_provider.dart';
import 'package:kabinet_indonesia/view_model/home_provider.dart';
import 'package:kabinet_indonesia/view_model/register_provider.dart';
import 'package:kabinet_indonesia/view_model/login_provider.dart';
import 'package:kabinet_indonesia/view_model/theme_app_provider.dart';
import 'package:provider/provider.dart';
import 'data/onboarding_local_datasource.dart';
import 'firebase_options.dart';
import 'view_model/get_data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await OnboardingLocalDatasource().initIntroduction();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          // child: LoginScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeAppProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],
      child: Consumer<ThemeAppProvider>(builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Aplikasi Kabinet Indonesia',
          theme: themeProvider.themeData,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      }),
    );
  }
}
