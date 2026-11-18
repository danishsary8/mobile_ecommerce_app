import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/haptic_service.dart';

class HapticButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isLoading;
  final bool isSecondary;
  final double height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const HapticButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isLoading = false,
    this.isSecondary = false,
    this.height = 54,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<HapticButton> createState() => _HapticButtonState();
}

class _HapticButtonState extends State<HapticButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null && !widget.isLoading) {
      _pressController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null && !widget.isLoading) {
      _pressController.reverse();
    }
  }

  void _onTapCancel() {
    _pressController.reverse();
  }

  void _onTap() {
    if (widget.onTap != null && !widget.isLoading) {
      HapticService.light();
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = widget.backgroundColor ??
        (widget.isSecondary
            ? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
            : (isDark ? Colors.white : AppColors.ctaDark));

    final fgColor = widget.foregroundColor ??
        (widget.isSecondary
            ? (isDark ? Colors.white : AppColors.textPrimaryLight)
            : (isDark ? AppColors.canvasDark : Colors.white));

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(widget.height / 2),
            border: widget.isSecondary
                ? Border.all(
                    color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
                  )
                : null,
            boxShadow: [
              if (!widget.isSecondary)
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.12),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 18, color: fgColor),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: AppTypography.buttonLabel(color: fgColor),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
