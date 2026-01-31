import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/product.dart';
import '../controllers/wishlist_controller.dart';
import '../routes/app_routes.dart';
import 'rating_stars.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistController>();

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.product, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16)),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.grey.shade200),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Name/Price/Rating
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF7A5CF4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      RatingStars(
                          rating: product.rating,
                          reviews: product.reviews),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),

            // ❤️ Wishlist icon
            Positioned(
              right: 8,
              top: 8,
              child: Obx(() {
                final isFav = wishlist.isFavorite(product);
                return GestureDetector(
                  onTap: () => wishlist.toggle(product),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                    size: 22,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
