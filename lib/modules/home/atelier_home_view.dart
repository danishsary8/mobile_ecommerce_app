import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/atelier_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/haptic_service.dart';
import '../../data/mock/mock_atelier_data.dart';
import '../../data/models/capsule_collection.dart';
import '../../shared/widgets/atelier_product_card.dart';
import '../../shared/widgets/editorial_shimmer_box.dart';
import 'atelier_runway_story_view.dart';
import '../lookbook/style_the_look_view.dart';
import '../concierge/atelier_concierge_sheet.dart';
import '../magazine/atelier_magazine_view.dart';
import '../runway/atelier_runway_live_view.dart';
import '../gifting/atelier_gifting_view.dart';

class AtelierHomeView extends StatefulWidget {
  const AtelierHomeView({super.key});

  @override
  State<AtelierHomeView> createState() => _AtelierHomeViewState();
}

class _AtelierHomeViewState extends State<AtelierHomeView> {
  final PageController _heroPageController = PageController(viewportFraction: 0.92);
  int _activeHeroIndex = 0;

  final List<String> _categories = [
    'All',
    'Outerwear',
    'Tailoring',
    'Dresses',
    'Knitwear',
    'Footwear',
    'Accessories',
  ];

  @override
  void dispose() {
    _heroPageController.dispose();
    super.dispose();
  }

  void _openRunwayStory(String storyLabel, String imageUrl) {
    HapticService.selection();
    final products = AtelierController.to.allProducts;
    final tagged1 = products.isNotEmpty ? products[0] : mockAtelierProducts.first;
    final tagged2 = products.length > 1 ? products[1] : mockAtelierProducts.first;
    final tagged3 = products.length > 2 ? products[2] : mockAtelierProducts.first;

    Get.to(
      () => AtelierRunwayStoryView(
        storyTitle: storyLabel,
        slides: [
          RunwayStorySlide(
            imageUrl: imageUrl,
            caption: '$storyLabel • Editorial Look 01',
            subCaption: 'Double-faced virgin wool with architectural cut.',
            taggedProduct: tagged1,
            tagPosition: const Offset(0.5, 0.44),
          ),
          RunwayStorySlide(
            imageUrl: tagged2.primaryImage,
            caption: '$storyLabel • Editorial Look 02',
            subCaption: 'Bias-cut mulberry silk tailored for nocturnal events.',
            taggedProduct: tagged2,
            tagPosition: const Offset(0.48, 0.50),
          ),
          RunwayStorySlide(
            imageUrl: tagged3.primaryImage,
            caption: '$storyLabel • Editorial Look 03',
            subCaption: '7-gauge Mongolian pure cashmere sculpt.',
            taggedProduct: tagged3,
            tagPosition: const Offset(0.52, 0.42),
          ),
        ],
      ),
      transition: Transition.fadeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AtelierController.to;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Editorial Transparent Sliver App Bar
          SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: isDark
                ? AppColors.canvasDark.withValues(alpha: 0.9)
                : AppColors.canvasLight.withValues(alpha: 0.9),
            elevation: 0,
            titleSpacing: 24,
            title: Text(
              'A T E L I E R',
              style: AppTypography.brandLogo(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            actions: [
              // Runway Live Stream Pill
              GestureDetector(
                onTap: () {
                  HapticService.light();
                  Get.to(
                    () => const AtelierRunwayLiveView(),
                    transition: Transition.fadeIn,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.saleRed.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.saleRed.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.circle_fill, size: 7, color: AppColors.saleRed),
                      SizedBox(width: 5),
                      Text(
                        'LIVE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: AppColors.saleRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),

              // Currency & Concierge Quick Pill
              GestureDetector(
                onTap: () => AtelierConciergeSheet.show(context),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
                    ),
                  ),
                  child: Obx(() => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.currencySymbol,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.selectedCurrencyCode.value,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: isDark ? AppColors.champagneGold : AppColors.ctaDark,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(width: 4),
              // Dark mode toggle
              IconButton(
                icon: Icon(
                  isDark ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
                  size: 20,
                  color: isDark ? AppColors.champagneGold : AppColors.ctaDark,
                ),
                onPressed: controller.toggleDarkMode,
              ),
              // Search direct shortcut
              IconButton(
                icon: Icon(
                  CupertinoIcons.search,
                  size: 22,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
                onPressed: () => controller.switchTab(1),
              ),
              const SizedBox(width: 12),
            ],
          ),

          // 2. Stories / Runway Lookbook Row
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  height: 96,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: mockStories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final story = mockStories[index];
                      return GestureDetector(
                        onTap: () => _openRunwayStory(story.label, story.imageUrl),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.champagneGold,
                                    Color(0xFFE8D8C8),
                                    AppColors.ctaDark,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? AppColors.canvasDark : AppColors.canvasLight,
                                ),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(story.imageUrl),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              story.label,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // 3. Hero Editorial Capsule Carousel
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _heroPageController,
                    itemCount: mockCapsules.length,
                    onPageChanged: (idx) {
                      HapticService.selection();
                      setState(() => _activeHeroIndex = idx);
                    },
                    itemBuilder: (context, index) {
                      final capsule = mockCapsules[index];
                      return _buildCapsuleCard(capsule, isDark);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Smooth Dot Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    mockCapsules.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _activeHeroIndex == i ? 22 : 6,
                      height: 5,
                      decoration: BoxDecoration(
                        color: _activeHeroIndex == i
                            ? (isDark ? AppColors.champagneGold : AppColors.ctaDark)
                            : (isDark ? Colors.white24 : Colors.black12),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // 4. Category Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return Obx(() {
                    final isSelected = controller.selectedCategory.value == cat;
                    return GestureDetector(
                      onTap: () => controller.selectCategory(cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark ? Colors.white : AppColors.ctaDark)
                              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: AppTypography.categoryChip(
                              isSelected: isSelected,
                              isDark: isDark,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ),

          // Editorial Lookbook Magazine Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: GestureDetector(
                onTap: () {
                  HapticService.light();
                  Get.to(
                    () => const AtelierMagazineView(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 350),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF141418) : const Color(0xFFF3EFEA),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.champagneGold.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.champagneGold.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.book_fill,
                          color: AppColors.champagneGold,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'L’ÉDITION N° 04 • EDITORIAL LOOKBOOK',
                              style: AppTypography.microTag(color: AppColors.champagneGold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'The Architecture of Drape',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white : AppColors.ctaDark,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'READ',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: isDark ? AppColors.canvasDark : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bespoke Gifting Concierge Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: GestureDetector(
                onTap: () {
                  HapticService.light();
                  Get.to(
                    () => const AtelierGiftingView(),
                    transition: Transition.fadeIn,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.champagneGold.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.champagneGold.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.gift_fill, size: 18, color: AppColors.champagneGold),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('L’ART DU CADEAU • BESPOKE GIFTING', style: AppTypography.microTag(color: AppColors.champagneGold)),
                            const SizedBox(height: 2),
                            Text(
                              'Curate luxury presentation boxes & calligraphy notes',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(CupertinoIcons.chevron_right, size: 14, color: AppColors.champagneGold),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 5. Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CURATED SELECTION',
                    style: AppTypography.sectionTitle(
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  Obx(() => Text(
                        '${controller.filteredProducts.length} PIECES',
                        style: AppTypography.microTag(
                          color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                        ),
                      )),
                ],
              ),
            ),
          ),

          // 6. Curated Editorial Grid (Staggered-like 2 Column layout)
          Obx(() {
            final products = controller.filteredProducts;

            if (products.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.tray,
                          size: 48,
                          color: isDark ? Colors.white30 : Colors.black26,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No pieces found in this category',
                          style: AppTypography.body(
                            color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Distribute into 2 columns for asymmetric staggered magazine look
            final leftColumn = <Widget>[];
            final rightColumn = <Widget>[];

            for (int i = 0; i < products.length; i++) {
              final isLeft = i % 2 == 0;
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AtelierProductCard(
                  product: products[i],
                  isStaggered: isLeft, // alternate heights
                ),
              );
              if (isLeft) {
                leftColumn.add(card);
              } else {
                rightColumn.add(card);
              }
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: leftColumn,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: rightColumn,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Bottom padding so items are not hidden behind floating glass bar
          const SliverToBoxAdapter(
            child: SizedBox(height: 110),
          ),
        ],
      ),
    );
  }

  Widget _buildCapsuleCard(CapsuleCollection capsule, bool isDark) {
    return GestureDetector(
      onTap: () {
        HapticService.selection();
        Get.to(
          () => const StyleTheLookView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            capsule.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: isDark ? const Color(0xFF202024) : const Color(0xFFE8E5DF),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const EditorialShimmerBox(
                borderRadius: BorderRadius.zero,
              );
            },
          ),
          // Editorial gradient scrim
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  Colors.black.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  capsule.tag,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: AppColors.champagneGold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  capsule.title,
                  style: AppTypography.sectionTitle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  capsule.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white54, width: 0.8),
                  ),
                  child: Text(
                    capsule.ctaText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
