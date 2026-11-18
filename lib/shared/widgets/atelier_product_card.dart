import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/atelier_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/haptic_service.dart';
import '../../data/models/product_model.dart';
import '../../modules/product_detail/atelier_pdp_view.dart';
import 'animated_heart_button.dart';
import 'editorial_shimmer_box.dart';

class AtelierProductCard extends StatefulWidget {
  final Product product;
  final bool isStaggered;

  const AtelierProductCard({
    super.key,
    required this.product,
    this.isStaggered = false,
  });

  @override
  State<AtelierProductCard> createState() => _AtelierProductCardState();
}

class _AtelierProductCardState extends State<AtelierProductCard>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerMove(PointerMoveEvent event, BoxConstraints constraints) {
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;
    final dx = (event.localPosition.dx - centerX) / centerX;
    final dy = (event.localPosition.dy - centerY) / centerY;

    setState(() {
      // Gentle 3D perspective angle (max ~0.06 radians / 3.5 degrees)
      _rotateX = (-dy * 0.06).clamp(-0.08, 0.08);
      _rotateY = (dx * 0.06).clamp(-0.08, 0.08);
    });
  }

  void _resetTilt() {
    setState(() {
      _isPressed = false;
      _rotateX = 0.0;
      _rotateY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = AtelierController.to;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Editorial card height variation for masonry look
    final imageHeight = widget.isStaggered ? 260.0 : 220.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Listener(
          onPointerDown: _onPointerDown,
          onPointerMove: (e) => _onPointerMove(e, constraints),
          onPointerUp: (_) => _resetTilt(),
          onPointerCancel: (_) => _resetTilt(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective depth
              ..rotateX(_rotateX)
              ..rotateY(_rotateY)
              ..scaleByDouble(
                _isPressed ? 0.98 : 1.0,
                _isPressed ? 0.98 : 1.0,
                1.0,
                1.0,
              ),
            transformAlignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                HapticService.light();
                Get.to(
                  () => AtelierPdpView(product: widget.product),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 320),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                      blurRadius: _isPressed ? 24 : 16,
                      offset: Offset(0, _isPressed ? 10 : 6),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Stack with Hero transition & Wishlist button
                    Stack(
                      children: [
                        Hero(
                          tag: 'product_img_${widget.product.id}',
                          child: Container(
                            height: imageHeight,
                            width: double.infinity,
                            color: isDark ? const Color(0xFF242428) : const Color(0xFFF0EFEA),
                            child: Image.network(
                              widget.product.primaryImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  size: 32,
                                  color: isDark ? Colors.white38 : Colors.black26,
                                ),
                              ),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return EditorialShimmerBox(
                                  height: imageHeight,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.zero,
                                );
                              },
                            ),
                          ),
                        ),
                        // Wishlist floating button
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Obx(() {
                            final isLiked = controller.isWishlisted(widget.product.id);
                            return AnimatedHeartButton(
                              isLiked: isLiked,
                              onToggle: (_) => controller.toggleWishlist(widget.product.id),
                            );
                          }),
                        ),
                        // New Season / Sale Tag
                        if (widget.product.isNewSeason || widget.product.originalPrice != null)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: widget.product.originalPrice != null
                                    ? AppColors.saleRed
                                    : (isDark ? Colors.white : AppColors.ctaDark),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.product.originalPrice != null ? 'SALE' : 'NEW SEASON',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: widget.product.originalPrice != null
                                      ? Colors.white
                                      : (isDark ? AppColors.canvasDark : Colors.white),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Product Details Block
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Swatches row
                          if (widget.product.colorVariants.isNotEmpty) ...[
                            Row(
                              children: widget.product.colorVariants.map((c) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: c.color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark ? Colors.white24 : Colors.black12,
                                      width: 1,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),
                          ],

                          // Category micro-text
                          Text(
                            widget.product.category.toUpperCase(),
                            style: AppTypography.microTag(
                              color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Product Title
                          Text(
                            widget.product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.productTitle(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Price Row
                          Row(
                            children: [
                              Obx(() => Text(
                                    controller.formatPrice(widget.product.price),
                                    style: AppTypography.priceTag(
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                    ),
                                  )),
                              if (widget.product.originalPrice != null) ...[
                                const SizedBox(width: 6),
                                Obx(() => Text(
                                      controller.formatPrice(widget.product.originalPrice!),
                                      style: AppTypography.originalPrice(),
                                    )),
                              ],
                              const Spacer(),
                              // Rating star
                              const Icon(Icons.star_rounded, size: 14, color: AppColors.champagneGold),
                              const SizedBox(width: 2),
                              Text(
                                widget.product.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
