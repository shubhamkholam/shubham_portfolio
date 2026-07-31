import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Container with animated gradient border effect
/// Inspired by Magic UI and Aceternity UI gradient borders
class GradientBorderContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<Color>? gradientColors;
  final double borderWidth;

  const GradientBorderContainer({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.gradientColors,
    this.borderWidth = 2,
  });

  @override
  State<GradientBorderContainer> createState() =>
      _GradientBorderContainerState();
}

class _GradientBorderContainerState extends State<GradientBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final gradientColors = widget.gradientColors ??
        (isDark
            ? const [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)]
            : const [Color(0xFF06B6D4), Color(0xFF3B82F6), Color(0xFF6366F1)]);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment(_animation.value * 2 - 1, -1),
              end: Alignment(_animation.value * 2 - 1, 1),
            ),
          ),
          padding: EdgeInsets.all(widget.borderWidth),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppTheme.cardColor : AppTheme.cardColor,
              borderRadius: (widget.borderRadius ?? BorderRadius.circular(24))
                  .subtract(BorderRadius.circular(widget.borderWidth)),
            ),
            padding: widget.padding ?? const EdgeInsets.all(24),
            child: widget.child,
          ),
        );
      },
    );
  }
}
