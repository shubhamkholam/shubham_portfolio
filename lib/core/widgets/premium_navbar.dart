import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

/// Floating glass navbar with blur effect and scroll animations
/// Inspired by Linear and Vercel navigation designs
class PremiumNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final List<NavItem> items;

  const PremiumNavbar({
    super.key,
    required this.scrollController,
    required this.items,
  });

  @override
  State<PremiumNavbar> createState() => _PremiumNavbarState();
}

class _PremiumNavbarState extends State<PremiumNavbar> {
  bool _isVisible = true;
  double _lastScrollOffset = 0;
  String _activeSection = 'home';

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final currentOffset = widget.scrollController.offset;
    final direction = currentOffset - _lastScrollOffset;

    if (direction > 0 && _isVisible) {
      setState(() => _isVisible = false);
    } else if (direction < 0 && !_isVisible) {
      setState(() => _isVisible = true);
    }

    _lastScrollOffset = currentOffset;
  }

  void _scrollToSection(String sectionId) {
    setState(() => _activeSection = sectionId);

    final context = widget.items.firstWhere((item) => item.id == sectionId).key;
    if (context.currentContext != null) {
      Scrollable.ensureVisible(
        context.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedSlide(
      offset: Offset(0, _isVisible ? 0 : -1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.02),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    children: [
                      // Logo
                      Text(
                        'SK',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      // Nav items
                      ...widget.items.map((item) {
                        final isActive = _activeSection == item.id;
                        return _NavItemWidget(
                          item: item,
                          isActive: isActive,
                          onTap: () => _scrollToSection(item.id),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ).animate().fadeIn(duration: 600.ms).slideY(),
    );
  }
}

class _NavItemWidget extends StatefulWidget {
  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItemWidget({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<_NavItemWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
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

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.isActive
                ? AppTheme.primaryColor.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.item.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: widget.isActive
                      ? AppTheme.primaryColor
                      : (isDark
                          ? AppTheme.textSecondaryColor
                          : AppTheme.textSecondaryColor),
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive || _isHovered ? 24 : 0,
                decoration: BoxDecoration(
                  gradient: AppTheme.auroraGradient1,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final String id;
  final String label;
  final GlobalKey key;

  NavItem({
    required this.id,
    required this.label,
  }) : key = GlobalKey();
}
