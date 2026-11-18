import 'package:clothing_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/orders_controller.dart';
import '../../data/order.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersCtrl = Get.find<OrdersController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ordersCtrl.orders.isEmpty) {
          return const Center(
            child: Text("No orders placed yet."),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: ordersCtrl.orders.length,
          itemBuilder: (context, index) {
            final Order o = ordersCtrl.orders[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text("Order #${o.id}"),
                subtitle: Text(
                  "${o.items.length} items • ${o.date.toLocal().toString().split(' ')[0]}",
                ),
                trailing: Text("\$${o.total.toStringAsFixed(2)}"),
                onTap: () {
                  Get.toNamed(AppRoutes.orderDetails, arguments: o); // 👈 This line
                },
              ),
            );
          },
        );
      }),
    );
  }
}
