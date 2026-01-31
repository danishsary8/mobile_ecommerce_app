import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../widgets/animated_primary_button.dart';

class ResetSentView extends StatelessWidget {
  const ResetSentView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.mark_email_read_rounded,
                    color: theme.colorScheme.primary,
                    size: 64,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Email Sent',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Check your inbox to reset your password.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: AnimatedPrimaryButton(
                    text: 'Back to Login',
                    onTap: () => Get.offAllNamed(AppRoutes.login),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
