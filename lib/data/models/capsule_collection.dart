class CapsuleCollection {
  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String ctaText;

  const CapsuleCollection({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.ctaText = 'EXPLORE CAPSULE',
  });
}
