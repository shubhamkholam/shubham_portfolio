import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Reusable section header widget with title and subtitle
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  final Color? titleColor;
  final Color? subtitleColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
    this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: theme.textTheme.headlineLarge?.copyWith(
            color: titleColor ?? theme.textTheme.headlineLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
                subtitle!,
                textAlign: textAlign,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: subtitleColor ?? theme.textTheme.bodyLarge?.color,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: -0.2, end: 0),
        ],
        const SizedBox(height: 48),
      ],
    );
  }
}
