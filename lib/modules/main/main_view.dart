import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/notifications_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme.dart';

import '../home/home_view.dart';
import '../search/search_view.dart';
import '../wishlist/wishlist_view.dart';
import '../notifications/notifications_view.dart';
import '../profile/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final CartController cartController = Get.find<CartController>();
  final NotificationsController notificationsController =
  Get.find<NotificationsController>();

  final List<Widget> _pages = const [
    HomeView(),
    SearchView(),
    WishlistView(),
    NotificationsView(),
    ProfileView(),
  ];

  final List<String> _titles = [
    'Discover',
    'Search',
    'Wishlist',
    'Notifications',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),

        // ===== Cart Icon with Badge =====
        actions: [
          Obx(() {
            final count = cartController.totalItems;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.cart);
                  },
                ),
                if (count > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
          const SizedBox(width: 8),
        ],
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: Obx(() {
        final unread = notificationsController.unreadCount;

        return NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);

            // Optional: mark all notifications as read when user opens Alerts tab
            if (index == 3) {
              notificationsController.markAllAsRead();
            }
          },
          height: 60,
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primary.withOpacity(0.10),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            const NavigationDestination(
              icon: Icon(Icons.favorite_border),
              label: 'Wishlist',
            ),

            // ===== Alerts with Badge =====
            NavigationDestination(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_none),
                  if (unread > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unread > 9 ? "9+" : unread.toString(),
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Alerts',
            ),

            const NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
