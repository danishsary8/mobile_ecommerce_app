import 'package:clothing_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/product.dart';
import '../../controllers/cart_controller.dart';
import '../../widgets/animated_primary_button.dart';
import '../../widgets/rating_stars.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late Product product;
  late CartController cartController;

  String selectedSize = '';
  int selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    product = Get.arguments as Product;
    cartController = Get.find<CartController>();

    // Default selected size
    if (product.sizes.isNotEmpty) {
      selectedSize = product.sizes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF7A5CF4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed(AppRoutes.cart);
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🖼 Product Image
                    Hero(
                      tag: product.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: Colors.grey.shade200),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 📌 Title & Price
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // ⭐ Rating
                    RatingStars(
                      rating: product.rating,
                      reviews: product.reviews,
                    ),

                    const SizedBox(height: 22),

                    // 📏 Size selector
                    if (product.sizes.isNotEmpty) ...[
                      const Text("Size",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        children: product.sizes.map((size) {
                          final isSelected = size == selectedSize;
                          return ChoiceChip(
                            label: Text(size),
                            selected: isSelected,
                            selectedColor: primary,
                            backgroundColor: Colors.grey.shade200,
                            onSelected: (_) {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // 🎨 Color selector
                    const Text("Color",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      children: List.generate(product.colors.length, (index) {
                        final colorValue = product.colors[index];
                        final isSelected = index == selectedColorIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Color(colorValue),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? primary
                                    : Colors.grey.shade300,
                                width: isSelected ? 2.5 : 1.5,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 22),

                    // 📝 Description
                    const Text("Description",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 100), // for spacing
                  ],
                ),
              ),
            ),

            // 🛒 **Add To Cart Button**
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedPrimaryButton(
                  text: "Add to Cart",
                  onTap: () {
                    cartController.add(product);
                    Get.snackbar(
                      "Added to Cart",
                      "${product.name} added successfully!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.lightGreen,
                      margin: const EdgeInsets.all(12),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
