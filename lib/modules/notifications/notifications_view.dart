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
          Get.defaultDialog(
            title: notification.title,
            content: Text(notification.invoice!),
            confirm: ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
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
        ),
        child: Row(
          children: [
            Icon(
              Icons.notifications,
              color: notification.isRead
                  ? Colors.black54
                  : AppColors.primary,
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
                  Text(notification.body),
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
}

