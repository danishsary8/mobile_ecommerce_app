import 'package:get/get.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  final String? invoice;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    this.invoice,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;

  // Computed getter for unread count
  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;

  void addNotification(NotificationItem notification) {
    notifications.insert(0, notification);
  }

  void markAsRead(NotificationItem notification) {
    final index = notifications.indexWhere((n) => n.id == notification.id);
    if (index != -1) {
      notifications[index].isRead = true;
      notifications.refresh();
    }
  }

  void markAllAsRead() {
    for (var n in notifications) {
      n.isRead = true;
    }
    notifications.refresh();
  }

  void clearAll() {
    notifications.clear();
  }
}
