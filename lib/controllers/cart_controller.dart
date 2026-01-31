import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/demo_products.dart';
import '../data/product.dart';

class CartItem {
  final Product product;
  final RxInt qty = 1.obs;

  CartItem(this.product);

  Map<String, dynamic> toJson() => {
    "id": product.id,
    "qty": qty.value,
  };
}

class CartController extends GetxController {
  final items = <String, CartItem>{}.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final data = box.read<List>('cartItems') ?? [];

    for (var e in data) {
      final String id = e['id'];
      final int qty = e['qty'];

      final Product prod = demoProducts.firstWhere((p) => p.id == id);

      items[prod.id] = CartItem(prod)..qty.value = qty;
    }
  }

  void saveToStorage() {
    final list = items.values.map((i) => i.toJson()).toList();
    box.write('cartItems', list);
  }

  void add(Product product) {
    if (items.containsKey(product.id)) {
      items[product.id]!.qty.value++;
    } else {
      items[product.id] = CartItem(product);
    }
    saveToStorage();
  }

  void remove(Product product) {
    items.remove(product.id);
    saveToStorage();
  }

  void increment(Product product) {
    items[product.id]?.qty.value++;
    saveToStorage();
  }

  void decrement(Product product) {
    if (items.containsKey(product.id)) {
      final item = items[product.id]!;
      if (item.qty.value > 1) {
        item.qty.value--;
      } else {
        items.remove(product.id);
      }
      saveToStorage();
    }
  }

  // ✅ FIX: This is what your cart_view.dart needs
  double get subtotal {
    double total = 0;
    for (final item in items.values) {
      total += item.product.price * item.qty.value;
    }
    return total;
  }

  // (Optional) Total quantity for badge
  int get totalItems {
    int total = 0;
    for (final item in items.values) {
      total += item.qty.value;
    }
    return total;
  }
}
