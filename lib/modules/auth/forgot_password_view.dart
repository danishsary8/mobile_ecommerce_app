import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../widgets/animated_primary_button.dart';
import '../../widgets/app_input.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Enter your email and we will send a reset link.'),
              const SizedBox(height: 24),

              AppInput(
                controller: emailController,
                hint: 'Email address / PhoneNumber',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: AnimatedPrimaryButton(
                  text: 'Continue',
                  onTap: () {
                    // TODO: Implement reset password logic
                    Get.toNamed(AppRoutes.resetSent);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
