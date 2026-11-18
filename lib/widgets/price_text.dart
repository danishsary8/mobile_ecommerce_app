import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? oldPrice;
  final bool bold;

  const PriceText({
    super.key,
    required this.price,
    this.oldPrice,
    this.bold = true,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF7A5CF4);

    return Row(
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            color: primary,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        if (oldPrice != null) ...[
          const SizedBox(width: 6),
          Text(
            '\$${oldPrice!.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}
