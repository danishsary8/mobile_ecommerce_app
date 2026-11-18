import 'package:flutter/material.dart';

class AnimatedPrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const AnimatedPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<AnimatedPrimaryButton> createState() => _AnimatedPrimaryButtonState();
}

class _AnimatedPrimaryButtonState extends State<AnimatedPrimaryButton> {
  bool _isHover = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF7A5CF4);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 52,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: _isHover ? 0.95 : 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isPressed
                ? []
                : [
              BoxShadow(
                color: primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
