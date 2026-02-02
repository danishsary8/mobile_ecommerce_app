import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notifications_controller.dart';
import '../../theme.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsCtrl = Get.find<NotificationsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Noti alerts"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              notificationsCtrl.clearAll();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (notificationsCtrl.notifications.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notificationsCtrl.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final n = notificationsCtrl.notifications[index];
              return _NotificationTile(notification: n);
            },
          );
        }),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<NotificationsController>()
            .markAsRead(notification);

        if (notification.invoice != null) {
          _showInvoiceDialog(
            context,
            title: notification.title,
            invoice: notification.invoice!,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.grey.shade100
              : AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: notification.isRead
                ? Colors.transparent
                : AppColors.primary,
            width: 1.6,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: notification.isRead
                    ? Colors.black12
                    : AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.notifications,
                color: notification.isRead
                    ? Colors.black54
                    : AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: notification.isRead
                            ? Colors.black87
                            : AppColors.primary,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(notification.time),
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black45),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  static String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else {
      return "${diff.inDays} days ago";
    }
  }

  static void _showInvoiceDialog(
      BuildContext context, {
        required String title,
        required String invoice,
      }) {
    Get.generalDialog(
      barrierLabel: "invoice",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.close),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Text(
                            invoice,
                            style: const TextStyle(height: 1.4),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Get.back(),
                                child: const Text("Close"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Get.back(),
                                child: const Text("Got it"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, _, child) {
        final slide = Tween<Offset>(
          begin: const Offset(0, -0.25),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));
        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}

