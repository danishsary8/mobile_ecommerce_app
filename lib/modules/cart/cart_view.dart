import 'package:clothing_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/animated_primary_button.dart';
import '../../theme.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const double deliveryCharge = 3.00;

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return _buildEmptyCart();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = cart.items.values.toList()[index];
                  return _CartItemCard(item: item);
                },
              ),
            ),

            // 🧾 Cart summary
            _CartSummary(cart: cart),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Add items from products to see them here.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [

          // 🖼 Image thumbnail
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 🧾 Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),
                Text(
                  "\$${item.product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // ➕〰️➖ Quantity controls
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => cart.decrement(item.product),
              ),
              Obx(() => Text(
                item.qty.value.toString(),
                style: const TextStyle(fontSize: 16),
              )),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => cart.increment(item.product),
              ),
            ],
          ),

          // 🗑 Remove
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => cart.remove(item.product),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final CartController cart;
  const _CartSummary({required this.cart});

  static const double deliveryCharge = 3.00;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subtotal = cart.subtotal;
      final total = subtotal + deliveryCharge;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [

            _priceRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
            _priceRow("Delivery", "\$${deliveryCharge.toStringAsFixed(2)}"),
            _priceRow("Tax", "\$0.00"),
            const Divider(height: 20),

            _priceRow(
              "Total",
              "\$${total.toStringAsFixed(2)}",
              bold: true,
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: AnimatedPrimaryButton(
                text: "Checkout",
                onTap: () {
                  Get.toNamed(AppRoutes.checkoutAddress);
                },
              ),
            ),

          ],
        ),
      );
    });
  }

  static Widget _priceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              )),
        ],
      ),
    );
  }
}
