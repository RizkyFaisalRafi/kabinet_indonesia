import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/theme_app_provider.dart';
import '../components/spaces.dart';
import 'package:kabinet_indonesia/constants/theme.dart';

class ThemeAppPage extends StatelessWidget {
  const ThemeAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema Aplikasi'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SpaceHeight(16),
          Consumer<ThemeAppProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text(
                  'Dark Theme',
                  style: fontJakartaSans.copyWith(
                    fontWeight: semiBold,
                    fontSize: fontMedium,
                  ),
                ),
                trailing: Switch(
                  value: themeProvider.themeData.brightness == Brightness.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
