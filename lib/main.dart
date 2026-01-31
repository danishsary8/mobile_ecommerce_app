import 'package:clothing_app/controllers/notifications_controller.dart';
import 'package:clothing_app/controllers/orders_controller.dart';
import 'package:clothing_app/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'package:get_storage/get_storage.dart';
import 'theme.dart';

// 👇 Import your controller
import 'controllers/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👇 Register CartController once at app start
  Get.put(CartController());
  Get.put(WishlistController());
  Get.put(OrdersController());
  Get.put(NotificationsController());


  await GetStorage.init(); // initialize storage
  runApp(const ClothingApp());
}

class ClothingApp extends StatelessWidget {
  const ClothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing App',
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
