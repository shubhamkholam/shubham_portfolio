import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animated scroll indicator
class ScrollIndicator extends StatelessWidget {
  const ScrollIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .moveY(
                  begin: 0,
                  end: 16,
                  duration: 1200.ms,
                  curve: Curves.easeInOut,
                ),
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),
        Text(
          'Scroll Down',
          style: Theme.of(context).textTheme.bodySmall,
        ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
      ],
    );
  }
}
