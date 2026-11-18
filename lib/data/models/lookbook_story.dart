class LookbookStory {
  final String id;
  final String label;
  final String imageUrl;
  final bool hasUnseen;

  const LookbookStory({
    required this.id,
    required this.label,
    required this.imageUrl,
    this.hasUnseen = true,
  });
}
