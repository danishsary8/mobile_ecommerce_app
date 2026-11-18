import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/product.dart';
import '../data/demo_products.dart';

class WishlistController extends GetxController {
  final items = <Product>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }


  void _loadWishlist() {
    final saved = box.read<List>('wishlist') ?? [];
    for (var id in saved) {
      final Product? prod = demoProducts.firstWhereOrNull((p) => p.id == id);
      if (prod != null) items.add(prod);
    }
  }

  void _saveWishlist() {
    final ids = items.map((p) => p.id).toList();
    box.write('wishlist', ids);
  }

  bool isFavorite(Product product) => items.contains(product);

  void toggle(Product product) {
    if (items.contains(product)) {
      items.remove(product);
    } else {
      items.add(product);
    }
    _saveWishlist();
  }
}
