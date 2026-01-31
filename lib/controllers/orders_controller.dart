import 'package:clothing_app/controllers/cart_controller.dart';
import 'package:clothing_app/data/demo_products.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/order.dart';
import '../data/product.dart';

class OrdersController extends GetxController {
  final box = GetStorage();
  final orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadOrders();
  }

  void _loadOrders() {
    final saved = box.read<List>('orders') ?? [];
    for (var data in saved) {
      final order = Order(
        id: data['id'],
        date: DateTime.parse(data['date']),
        items: (data['items'] as List).map((e) {
          final prod = demoProducts.firstWhere((p) => p.id == e['id']);
          final ci = CartItem(prod)..qty.value = e['qty'];
          return ci;
        }).toList(),
        total: data['total'],
      );
      orders.add(order);
    }
  }

  void _saveOrders() {
    final saveList = orders.map((o) {
      return {
        'id': o.id,
        'date': o.date.toIso8601String(),
        'total': o.total,
        'items': o.items.map((i) => i.toJson()).toList(),
      };
    }).toList();
    box.write('orders', saveList);
  }

  void addOrder(Order order) {
    orders.insert(0, order);
    _saveOrders();
  }
}
