import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/wishlist_controller.dart';
import '../../widgets/product_card.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
      ),
      body: Obx(() {
        if (wishlist.items.isEmpty) {
          return _emptyView();
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),
          itemCount: wishlist.items.length,
          itemBuilder: (context, index) {
            final product = wishlist.items[index];
            return ProductCard(product: product);
          },
        );
      }),
    );
  }

  Widget _emptyView() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Your wishlist is empty.\nAdd products to save them here!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
