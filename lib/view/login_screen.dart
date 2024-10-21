import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:kabinet_indonesia/components/custom_text_field.dart';
import 'package:kabinet_indonesia/components/spaces.dart';
import 'package:kabinet_indonesia/constants/app_colors.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:kabinet_indonesia/view/register_screen.dart';
import 'package:kabinet_indonesia/view_model/login_provider.dart';
import 'package:provider/provider.dart';
import '../components/buttons.dart';
import '../components/dialog_animate.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kabinet Indonesia',
                style: fontJakartaSans.copyWith(
                  fontSize: fontExtra,
                  fontWeight: bold,
                  color: Colors.amber,
                ),
              ),
              const SpaceHeight(20),
              Text(
                'Hallo Selamat Datang di Aplikasi Cabinet!, Untuk masuk silahkan isi data kamu terlebih dahulu ya!',
                style: fontJakartaSans.copyWith(
                  fontSize: fontSmall,
                  fontWeight: medium,
                ),
              ),

              const SpaceHeight(20),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: provider.emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validate: provider.validateEmail,
                    ),
                    const SpaceHeight(20),

                    // Kata Sandi
                    Consumer<LoginProvider>(
                      builder: (context, data, _) {
                        return CustomTextField(
                          controller: provider.passController,
                          label: 'Kata Sandi',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: provider.obscureText,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          validate: provider.validatePass,
                          suffixIcon: IconButton(
                            icon: Iconify(
                              provider.obscureText
                                  ? Eva.eye_off_outline
                                  : Eva.eye_outline,
                              color: provider.obscureText
                                  ? Colors.grey
                                  : const Color(0XFF7CA153),
                            ),
                            onPressed: () {
                              provider.toggleObscureText();
                            },
                          ),
                        );
                      },
                    ),

                    const SpaceHeight(50),

                    // Button Masuk
                    Consumer<LoginProvider>(builder: (context, prov, _) {
                      return Button.filled(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            try {
                              provider.authenticateLogin(context);
                              provider.emailController.clear();
                              provider.passController.clear();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon isi semua form'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        label: prov.isLoading ? 'Loading' : 'Masuk',
                      );
                    }),
                  ],
                ),
              ),
              // Email

              const SpaceHeight(50),

              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Atau Sign In dengan',
                      style: fontJakartaSans.copyWith(
                        fontSize: fontExtraSmall,
                        fontWeight: reguler,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SpaceHeight(50),

              Button.outlined(
                onPressed: () {
                  DialogAnimate.show(
                    context,
                    title: 'Coming Soon',
                    content: 'Fitur Google Belum Tersedia',
                  );
                },
                label: 'Google',
                icon: const Iconify(
                  Zondicons.globe,
                  color: AppColors.primary,
                ),
              ),

              const SpaceHeight(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: fontJakartaSans.copyWith(
                      fontSize: fontExtraSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      provider.emailController.clear();
                      provider.passController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: fontJakartaSans.copyWith(
                        fontSize: fontExtraSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
