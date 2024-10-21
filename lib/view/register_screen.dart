import 'package:kabinet_indonesia/view_model/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:kabinet_indonesia/components/buttons.dart';
import 'package:kabinet_indonesia/view/login_screen.dart';
import 'package:provider/provider.dart';
import '../components/custom_text_field.dart';
import '../components/dialog_animate.dart';
import '../components/spaces.dart';
import '../constants/app_colors.dart';
import '../constants/theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

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
                'Halo selamat datang di aplikasi Cabinet!, untuk mendaftar silahkan lengkapi data diri terlebih dahulu!',
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
                    // Nama
                    CustomTextField(
                      controller: provider.nameController,
                      label: 'Nama',
                      keyboardType: TextInputType.name,
                      validate: provider.validateName,
                    ),
                    const SpaceHeight(20),

                    // No Hp
                    CustomTextField(
                      controller: provider.numberPhoneController,
                      label: 'Nomor Telephone',
                      keyboardType: TextInputType.number,
                      validate: provider.validateNumberPhone,
                    ),
                    const SpaceHeight(20),

                    // Alamat
                    CustomTextField(
                      controller: provider.addressController,
                      label: 'Alamat',
                      keyboardType: TextInputType.text,
                      validate: provider.validateAddress,
                    ),
                    const SpaceHeight(20),

                    // Email
                    CustomTextField(
                      controller: provider.emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validate: provider.validateEmail,
                    ),
                    const SpaceHeight(20),

                    // Kata Sandi
                    Consumer<RegisterProvider>(
                      builder: (context, data, _) {
                        return CustomTextField(
                          controller: provider.passController,
                          label: 'Kata Sandi',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: provider.obscureText1,
                          validate: provider.validatePass,
                          suffixIcon: IconButton(
                            icon: Iconify(
                              provider.obscureText1
                                  ? Eva.eye_off_outline
                                  : Eva.eye_outline,
                              color: provider.obscureText1
                                  ? Colors.grey
                                  : AppColors.primary,
                            ),
                            onPressed: () {
                              data.toggleObscureText1();
                            },
                          ),
                        );
                      },
                    ),
                    const SpaceHeight(20),

                    // Ulangi Kata Sandi
                    Consumer<RegisterProvider>(
                      builder: (context, data, _) {
                        return CustomTextField(
                          controller: provider.repeatPassController,
                          label: 'Ulangi Kata Sandi',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: provider.obscureText2,
                          validate: provider.validatePassRepeat,
                          suffixIcon: IconButton(
                            icon: Iconify(
                              provider.obscureText2
                                  ? Eva.eye_off_outline
                                  : Eva.eye_outline,
                              color: provider.obscureText2
                                  ? Colors.grey
                                  : AppColors.primary,
                            ),
                            onPressed: () {
                              data.toggleObscureText2();
                            },
                          ),
                        );
                      },
                    ),
                    const SpaceHeight(50),

                    Consumer<RegisterProvider>(builder: (context, prov, _) {
                      return Button.filled(
                        onPressed: prov.isLoading
                            ? () {
                                null;
                              }
                            : () {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    prov.authenticateRegister(context);
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
                        label: prov.isLoading ? 'Loading' : 'Daftar',
                      );
                    }),
                  ],
                ),
              ),
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
                    child: Text('Atau Sign Up dengan',
                        style: fontJakartaSans.copyWith(
                          fontSize: fontExtraSmall,
                          fontWeight: reguler,
                        )),
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
                    'Sudah punya akun?',
                    style: fontJakartaSans.copyWith(
                      fontSize: fontExtraSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      provider.nameController.clear();
                      provider.numberPhoneController.clear();
                      provider.addressController.clear();
                      provider.emailController.clear();
                      provider.passController.clear();
                      provider.repeatPassController.clear();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign In',
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
