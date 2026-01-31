import 'package:flutter/material.dart';
import '../../widgets/animated_primary_button.dart';
import '../../widgets/app_input.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              AppInput(
                hint: 'First name',
                controller: firstNameController,
              ),
              const SizedBox(height: 14),

              AppInput(
                hint: 'Last name',
                controller: lastNameController,
              ),
              const SizedBox(height: 14),

              AppInput(
                hint: 'Phone Number address',
                controller: phoneController,
              ),
              const SizedBox(height: 14),

              AppInput(
                hint: 'Email address',
                controller: emailController,
              ),
              const SizedBox(height: 14),

              AppInput(
                hint: 'Password',
                obscure: true,
                controller: passwordController,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: AnimatedPrimaryButton(
                  text: 'Continue',
                  onTap: () {
                    // TODO: Implement register logic
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
