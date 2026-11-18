import 'product_model.dart';

class CartItem {
  final String id;
  final Product product;
  final String selectedSize;
  final ProductColorVariant selectedColor;
  final String? monogramSummary;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.monogramSummary,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
