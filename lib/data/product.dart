class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviews;
  final List<String> sizes;
  final List<int> colors;
  final String image;
  final String description; // new

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.sizes,
    required this.colors,
    required this.image,
    required this.description, // new
  });
}
