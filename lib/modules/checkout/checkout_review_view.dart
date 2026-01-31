import 'package:clothing_app/controllers/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../data/order.dart';
import '../../routes/app_routes.dart';

class CheckoutReviewView extends StatelessWidget {
  const CheckoutReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final ordersCtrl = Get.find<OrdersController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Review Order",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // 🟦 Items List
            Expanded(
              child: ListView(
                children: cart.items.values.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            item.product.image,
                            width: 62,
                            height: 62,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: const TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "\$${item.product.price.toStringAsFixed(2)} x ${item.qty.value}",
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Total per item
                        Text(
                          "\$${(item.product.price * item.qty.value).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // 🟩 Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  _priceRow(
                    "Subtotal",
                    "\$${cart.subtotal.toStringAsFixed(2)}",
                  ),
                  _priceRow("Delivery", "\$3.00"),
                  _priceRow("Tax", "\$0.00"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(thickness: 1),
                  ),
                  _priceRow(
                    "Total",
                    "\$${(cart.subtotal + 3).toStringAsFixed(2)}",
                    bold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 🟦 Place Order Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  // create new order
                  // create the order
                  final newOrder = Order(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    date: DateTime.now(),
                    items: cart.items.values.toList(),
                    total: cart.subtotal + 3,
                  );

// Build invoice summary text
                  final invoiceLines = newOrder.items
                      .map((item) =>
                  "${item.product.name} x${item.qty.value}: \$${(item.product.price * item.qty.value).toStringAsFixed(2)}")
                      .join("\n");

                  final invoiceText =
                      "Order #${newOrder.id}\n$invoiceLines\nShipping: \$8.00\nTotal: \$${newOrder.total.toStringAsFixed(2)}";

// add notification
                  final notificationsCtrl =
                  Get.find<NotificationsController>();
                  notificationsCtrl.addNotification(
                    NotificationItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: "Order Confirmed!",
                      body:
                      "Your order #${newOrder.id} has been placed successfully!",
                      invoice: invoiceText, // 🟢 now defined correctly
                      time: DateTime.now(),
                    ),
                  );

// save order
                  ordersCtrl.addOrder(newOrder);

// clear cart
                  cart.items.clear();
                  cart.saveToStorage();

// navigate to success screen
                  Get.offAllNamed(AppRoutes.orderSuccess);
                },
                child: const Text("Place Order"),
              ),
            ),

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  static Widget _priceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: bold ? 16.5 : 15.5,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              color: bold ? Colors.black87 : Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 16.5 : 15.5,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              color: bold ? const Color(0xFF3B82F6) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
