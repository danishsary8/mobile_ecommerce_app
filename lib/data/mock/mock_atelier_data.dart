import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/capsule_collection.dart';
import '../models/lookbook_story.dart';

// ==========================================
// EDITORIAL RUNWAY STORIES (Stories Carousel)
// ==========================================
final List<LookbookStory> mockStories = [
  const LookbookStory(
    id: 's1',
    label: 'Summer 26',
    imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's2',
    label: 'Monochrome',
    imageUrl: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's3',
    label: 'Pure Silk',
    imageUrl: 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's4',
    label: 'Cashmere',
    imageUrl: 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's5',
    label: 'Tailoring',
    imageUrl: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's6',
    label: 'Leathercraft',
    imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's7',
    label: 'Footwear',
    imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&w=600&q=85',
  ),
  const LookbookStory(
    id: 's8',
    label: 'Nocturne',
    imageUrl: 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?auto=format&fit=crop&w=600&q=85',
  ),
];

// ==========================================
// FEATURED CAPSULE COLLECTIONS (Hero Banner)
// ==========================================
final List<CapsuleCollection> mockCapsules = [
  const CapsuleCollection(
    id: 'c1',
    tag: 'LIMITED EDITION // SPRING 26',
    title: 'The Architectural Silhouette',
    subtitle: 'Sculptural tailoring and fluid silhouettes crafted in Northern Italy.',
    imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=1400&q=85',
    ctaText: 'DISCOVER CAPSULE',
  ),
  const CapsuleCollection(
    id: 'c2',
    tag: 'NEW ARRIVALS // SUSTAINABLE EDIT',
    title: 'Minimalist Raw Linen',
    subtitle: 'Unfinished seams and natural earth pigments for timeless warm ease.',
    imageUrl: 'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?auto=format&fit=crop&w=1400&q=85',
    ctaText: 'EXPLORE EDIT',
  ),
  const CapsuleCollection(
    id: 'c3',
    tag: 'COUTURE CRAFT // PARIS RUNWAY',
    title: 'Nocturne Noir Eveningwear',
    subtitle: 'Obsidian silks and sharp-lapeled jackets tailored for midnight.',
    imageUrl: 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?auto=format&fit=crop&w=1400&q=85',
    ctaText: 'SHOP RUNWAY PIECES',
  ),
  const CapsuleCollection(
    id: 'c4',
    tag: 'ESSENTIALS // CAPSULE 04',
    title: 'Neutral Cashmere Layers',
    subtitle: 'Whisper-soft 7-gauge Mongolian cashmere for effortless transitional dressing.',
    imageUrl: 'https://images.unsplash.com/photo-1516762689617-e1cffcef479d?auto=format&fit=crop&w=1400&q=85',
    ctaText: 'DISCOVER KNITWEAR',
  ),
];

// ==========================================
// COMPLETE REAL HIGH-FASHION SEEDER CATALOG
// ==========================================
final List<Product> mockAtelierProducts = [
  // 1. OUTERWEAR
  const Product(
    id: 'atl_01',
    title: 'Double-Breasted Wool Trench',
    category: 'Outerwear',
    price: 490.00,
    originalPrice: 580.00,
    rating: 4.9,
    reviewsCount: 142,
    stockLeft: 3,
    isNewSeason: true,
    isTrending: true,
    sizes: ['XS', 'S', 'M', 'L'],
    description:
        'Masterfully tailored from heavyweight double-faced Italian virgin wool. Features storm flaps, raglan sleeves, hand-carved horn buttons, and a belted waist.',
    fabricCare: '100% Virgin Wool. Full cupro lining. Specialist dry clean only.',
    sizeFitNotes: 'Designed for an effortless relaxed drape. Model is 178cm wearing size S.',
    colorVariants: [
      ProductColorVariant(
        name: 'Oatmeal Taupe',
        color: Color(0xFFD4C7B5),
        images: [
          'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=1200&q=85',
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Obsidian Noir',
        color: Color(0xFF141416),
        images: [
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Champagne Ochre',
        color: Color(0xFFC8A77B),
        images: [
          'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 2. DRESSES
  const Product(
    id: 'atl_02',
    title: 'Bias-Cut Silk Slip Dress',
    category: 'Dresses',
    price: 340.00,
    rating: 4.8,
    reviewsCount: 96,
    stockLeft: 2,
    isNewSeason: true,
    isTrending: true,
    sizes: ['XS', 'S', 'M'],
    description:
        'Fluid mulberry silk cut on the bias to sculpt every curve. Features delicate spaghetti straps and a modern cowl backline designed for nocturnal soirees.',
    fabricCare: '100% Mulberry Silk (22 Momme). Gentle hand wash cold or dry clean.',
    sizeFitNotes: 'True to size with natural fluidity. Falls gracefully below the knee.',
    colorVariants: [
      ProductColorVariant(
        name: 'Champagne Sheen',
        color: Color(0xFFEBDBC9),
        images: [
          'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&w=1200&q=85',
          'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Bordeaux Velvet',
        color: Color(0xFF4A121A),
        images: [
          'https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 3. KNITWEAR
  const Product(
    id: 'atl_03',
    title: 'Cashmere Heavy Knit Sweater',
    category: 'Knitwear',
    price: 380.00,
    originalPrice: 420.00,
    rating: 4.95,
    reviewsCount: 180,
    stockLeft: 5,
    isNewSeason: false,
    isTrending: true,
    sizes: ['S', 'M', 'L', 'XL'],
    description:
        'Spun from 7-gauge pure Mongolian cashmere yarn. Extra-soft ribbed turtle neckline and dropped shoulders create a cozy, sculptural profile.',
    fabricCare: '100% Mongolian Cashmere. Hand wash with wool detergent; lay flat to dry.',
    sizeFitNotes: 'Slightly oversized boyfriend fit. Choose normal size for slouchy aesthetic.',
    colorVariants: [
      ProductColorVariant(
        name: 'Ivory Cream',
        color: Color(0xFFF3ECE2),
        images: [
          'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Charcoal Slate',
        color: Color(0xFF333336),
        images: [
          'https://images.unsplash.com/photo-1516762689617-e1cffcef479d?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 4. FOOTWEAR
  const Product(
    id: 'atl_04',
    title: 'Sculpted Minimalist Leather Loafer',
    category: 'Footwear',
    price: 420.00,
    rating: 4.7,
    reviewsCount: 64,
    stockLeft: 4,
    isNewSeason: true,
    sizes: ['38', '39', '40', '41', '42'],
    description:
        'Hand-buffed calfskin leather loafers constructed on an ergonomic square-toe last. Finished with a subtle block heel and brushed gold hardware bit.',
    fabricCare: '100% Full-grain Italian Calfskin. Polish with natural leather balm.',
    sizeFitNotes: 'Supple leather conforms to foot width after first 2 wears.',
    colorVariants: [
      ProductColorVariant(
        name: 'Burnished Espresso',
        color: Color(0xFF2C1E18),
        images: [
          'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Jet Black',
        color: Color(0xFF101010),
        images: [
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 5. OUTERWEAR / BOTTOMS
  const Product(
    id: 'atl_05',
    title: 'Pleated Wide-Leg Palazzo Trouser',
    category: 'Outerwear',
    price: 290.00,
    rating: 4.85,
    reviewsCount: 112,
    stockLeft: 6,
    isNewSeason: false,
    sizes: ['XS', 'S', 'M', 'L'],
    description:
        'High-waisted tailored trousers featuring deep inverted front pleats, sharp pressed creases, and slant side pockets. Flowing drape with every stride.',
    fabricCare: '70% Virgin Wool, 30% Silk Crepe. Dry clean only.',
    sizeFitNotes: 'High-rise waist. Hemline rests cleanly on footwear.',
    colorVariants: [
      ProductColorVariant(
        name: 'Stone Sand',
        color: Color(0xFFDDD2C4),
        images: [
          'https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Pitch Black',
        color: Color(0xFF1A1A1A),
        images: [
          'https://images.unsplash.com/photo-1479064555552-3ef4979f8908?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 6. ACCESSORIES
  const Product(
    id: 'atl_06',
    title: 'Architectural Curve Shoulder Bag',
    category: 'Accessories',
    price: 520.00,
    rating: 4.9,
    reviewsCount: 78,
    stockLeft: 1,
    isNewSeason: true,
    isTrending: true,
    sizes: ['One Size'],
    description:
        'A sculptural crescent handbag crafted from smooth Nappa leather. Signature concealed magnetic clasp and an adjustable strap for shoulder or crossbody styling.',
    fabricCare: 'Nappa leather exterior, suede microfiber lining.',
    sizeFitNotes: 'Dimensions: 28cm x 16cm x 7cm. Fits phone, cardholder, keys.',
    colorVariants: [
      ProductColorVariant(
        name: 'Caramel Cognac',
        color: Color(0xFF9E5B32),
        images: [
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Chalk White',
        color: Color(0xFFF6F4F0),
        images: [
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 7. DRESSES
  const Product(
    id: 'atl_07',
    title: 'Asymmetrical Draped Halter Gown',
    category: 'Dresses',
    price: 460.00,
    originalPrice: 520.00,
    rating: 4.92,
    reviewsCount: 52,
    stockLeft: 2,
    isNewSeason: true,
    sizes: ['XS', 'S', 'M'],
    description:
        'Floor-grazing evening silhouette cut from luminous washed satin. Sculpted neck drape and an architectural open back with slender silk tie ribbons.',
    fabricCare: '100% Silk Satin. Specialist dry clean only.',
    sizeFitNotes: 'Designed for an elongated silhouette. Pairs effortlessly with heels.',
    colorVariants: [
      ProductColorVariant(
        name: 'Emerald Moss',
        color: Color(0xFF1E382B),
        images: [
          'https://images.unsplash.com/photo-1566174053879-31528523f8ae?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Midnight Navy',
        color: Color(0xFF121B28),
        images: [
          'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 8. OUTERWEAR
  const Product(
    id: 'atl_08',
    title: 'Oversized Shearling Bomber Jacket',
    category: 'Outerwear',
    price: 680.00,
    rating: 4.97,
    reviewsCount: 89,
    stockLeft: 2,
    isNewSeason: true,
    isTrending: true,
    sizes: ['S', 'M', 'L'],
    description:
        'Handcrafted from genuine Spanish merino shearling with a cracked vintage leather exterior and plush curly wool interior for supreme winter warmth.',
    fabricCare: '100% Merino Shearling. Professional leather and fur specialist only.',
    sizeFitNotes: 'Boxy aviator fit with dropped shoulders and adjustable buckled collar.',
    colorVariants: [
      ProductColorVariant(
        name: 'Espresso Brown',
        color: Color(0xFF382923),
        images: [
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Washed Charcoal',
        color: Color(0xFF28282B),
        images: [
          'https://images.unsplash.com/photo-1520975954732-35dd22299614?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 9. KNITWEAR
  const Product(
    id: 'atl_09',
    title: 'Fine Gauge Ribbed Polo Knit',
    category: 'Knitwear',
    price: 240.00,
    rating: 4.75,
    reviewsCount: 104,
    stockLeft: 7,
    isNewSeason: false,
    sizes: ['XS', 'S', 'M', 'L'],
    description:
        'Spun from ultra-fine Australian Merino wool and mulberry silk. Features a collarless Johnny polo neck, seamless linked shoulders, and fitted cuffs.',
    fabricCare: '75% Extra-Fine Merino, 25% Silk. Hand wash cold.',
    sizeFitNotes: 'Slim, body-skimming fit suitable for tucking into tailored trousers.',
    colorVariants: [
      ProductColorVariant(
        name: 'Raw Ecru',
        color: Color(0xFFF0EDE5),
        images: [
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Olive Sage',
        color: Color(0xFF555D50),
        images: [
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 10. FOOTWEAR
  const Product(
    id: 'atl_10',
    title: 'Square-Toe Glove Leather Ankle Boot',
    category: 'Footwear',
    price: 490.00,
    originalPrice: 550.00,
    rating: 4.88,
    reviewsCount: 71,
    stockLeft: 3,
    isNewSeason: true,
    sizes: ['37', '38', '39', '40', '41'],
    description:
        'Crafted from second-skin lambskin leather that molds to the ankle. Features an architectural flared block heel and an invisible inner zip closure.',
    fabricCare: '100% Italian Lambskin. Store with cedar shoe trees.',
    sizeFitNotes: 'True to European size. 65mm comfortable all-day block heel.',
    colorVariants: [
      ProductColorVariant(
        name: 'Pitch Black',
        color: Color(0xFF0F0F10),
        images: [
          'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Warm Biscotti',
        color: Color(0xFFD2B48C),
        images: [
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 11. ACCESSORIES
  const Product(
    id: 'atl_11',
    title: 'Sculptural Brushed Brass Cuff',
    category: 'Accessories',
    price: 195.00,
    rating: 4.82,
    reviewsCount: 43,
    stockLeft: 5,
    isNewSeason: true,
    sizes: ['One Size'],
    description:
        'Hand-forged brass bracelet featuring an organic, molten contour with an antique satin finish. Subtle interior Atelier hallmark engraving.',
    fabricCare: '18k Gold-plated solid brass. Avoid water and perfumes.',
    sizeFitNotes: 'Pliable gently to adjust to wrist circumference.',
    colorVariants: [
      ProductColorVariant(
        name: 'Satin Gold',
        color: Color(0xFFCFB53B),
        images: [
          'https://images.unsplash.com/photo-1611591475819-79b8b73ff2f3?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Sterling Silver',
        color: Color(0xFFC0C0C0),
        images: [
          'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 12. ACCESSORIES
  const Product(
    id: 'atl_12',
    title: 'Acetate Cat-Eye Sunglasses',
    category: 'Accessories',
    price: 260.00,
    rating: 4.9,
    reviewsCount: 65,
    stockLeft: 4,
    isNewSeason: false,
    sizes: ['One Size'],
    description:
        'Chunky Italian Mazzucchelli acetate frames with sharp bevelled edges and 100% UV400 category 3 dark tinted lenses.',
    fabricCare: 'Handmade acetate. Wipe clean with microfiber cloth.',
    sizeFitNotes: 'Medium fit. Universal nose bridge.',
    colorVariants: [
      ProductColorVariant(
        name: 'Tortoiseshell Amber',
        color: Color(0xFF593E2B),
        images: [
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Gloss Onyx',
        color: Color(0xFF141414),
        images: [
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 13. LUXURY SHEARLING
  const Product(
    id: 'atl_13',
    title: 'Reversible Double-Faced Shearling Gilet',
    category: 'Outerwear',
    price: 720.00,
    originalPrice: 850.00,
    rating: 4.96,
    reviewsCount: 38,
    stockLeft: 2,
    isNewSeason: true,
    isTrending: true,
    sizes: ['S', 'M', 'L'],
    description:
        'Supple Spanish merino shearling with a velvet suede face on one side and plush curly lamb fleece on reverse. Horn toggle loop closures.',
    fabricCare: '100% Spanish Merino Shearling. Specialist leather care only.',
    sizeFitNotes: 'Relaxed volumetric silhouette designed for layering over chunky knitwear.',
    colorVariants: [
      ProductColorVariant(
        name: 'Caramel Suede',
        color: Color(0xFF9E724C),
        images: [
          'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=1200&q=85',
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Noir Shearling',
        color: Color(0xFF121214),
        images: [
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),

  // 14. TAILORING
  const Product(
    id: 'atl_14',
    title: 'Pleated High-Rise Palazzo Trousers',
    category: 'Tailoring',
    price: 360.00,
    rating: 4.92,
    reviewsCount: 84,
    stockLeft: 4,
    isNewSeason: true,
    sizes: ['36', '38', '40', '42'],
    description:
        'Tailored from featherweight tropical worsted wool. Deep double forward pleats create an elegant, fluid column leg with sharp front creases.',
    fabricCare: '100% Super 130s Worsted Wool. Dry clean only.',
    sizeFitNotes: 'High-rise waist. Inseam designed to fall gracefully over block heel footwear.',
    colorVariants: [
      ProductColorVariant(
        name: 'Oatmeal Taupe',
        color: Color(0xFFC7BCAB),
        images: [
          'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
      ProductColorVariant(
        name: 'Obsidian Noir',
        color: Color(0xFF101012),
        images: [
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=1200&q=85',
        ],
      ),
    ],
  ),
];
