import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Card with magnetic hover effect that follows mouse movement
/// Inspired by Linear and Apple interactive cards
class MagneticHoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final double magneticStrength;

  const MagneticHoverCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    this.magneticStrength = 0.3,
  });

  @override
  State<MagneticHoverCard> createState() => _MagneticHoverCardState();
}

class _MagneticHoverCardState extends State<MagneticHoverCard>
    with SingleTickerProviderStateMixin {
  Offset _mousePosition = Offset.zero;
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateMousePosition(PointerEvent event) {
    setState(() {
      _mousePosition = event.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _mousePosition = Offset.zero;
        });
        _controller.reverse();
      },
      onHover: _updateMousePosition,
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double rotateX = 0;
          double rotateY = 0;

          if (_isHovered) {
            final renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              final localPosition = renderBox.globalToLocal(_mousePosition);
              final size = renderBox.size;
              final centerX = size.width / 2;
              final centerY = size.height / 2;

              rotateX = ((localPosition.dy - centerY) / centerY) *
                  widget.magneticStrength;
              rotateY = -((localPosition.dx - centerX) / centerX) *
                  widget.magneticStrength;
            }
          }

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(rotateX)
              ..rotateY(rotateY)
              ..scale(_scaleAnimation.value),
            child: Container(
              width: widget.width,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.cardColor : AppTheme.cardColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(24),
                    child: Padding(
                      padding: widget.padding ?? const EdgeInsets.all(24),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
