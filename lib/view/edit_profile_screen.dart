import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/components/buttons.dart';
import 'package:kabinet_indonesia/components/custom_text_field.dart';
import 'package:kabinet_indonesia/components/spaces.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import 'package:kabinet_indonesia/view_model/edit_profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultMargin),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Name
                CustomTextField(
                  controller: provider.nameController,
                  label: 'Name',
                  validate: provider.validateName,
                ),
                const SpaceHeight(20),

                // Address
                CustomTextField(
                  controller: provider.addressController,
                  label: 'Address',
                  validate: provider.validateAddress,
                ),
                const SpaceHeight(20),
                // Phone
                CustomTextField(
                  controller: provider.numberPhoneController,
                  label: 'Phone',
                  validate: provider.validateNumberPhone,
                ),

                const SpaceHeight(50),

                Consumer<EditProfileProvider>(
                  builder: (context, prov, _) {
                    return Button.filled(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            try {
                              prov.updateProfile(context);
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
                        label: 'Update Profil');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
