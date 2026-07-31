import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/premium_glass_card.dart';
import '../../core/widgets/gradient_border_container.dart';

/// Achievement data model
class Achievement {
  final String label;
  final int value;
  final IconData icon;
  final String suffix;

  Achievement({
    required this.label,
    required this.value,
    required this.icon,
    this.suffix = '+',
  });
}

/// Premium Achievements Section with animated counters and glass cards
/// Inspired by Linear and Vercel stats sections
class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  static final List<Achievement> achievements = [
    Achievement(label: 'Years of Experience', value: 6, icon: Icons.work),
    Achievement(label: 'Apps Published', value: 15, icon: Icons.apps),
    Achievement(label: 'Happy Clients', value: 20, icon: Icons.people),
    Achievement(
      label: 'Projects Completed',
      value: 30,
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200 ? 120 : 24,
        vertical: 100,
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Achievements',
            subtitle: 'Numbers that speak for themselves',
          ),

          const SizedBox(height: 64),

          // Premium achievement cards
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = size.width > 1200
                  ? 4
                  : size.width > 800
                      ? 2
                      : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                ),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  return _PremiumAchievementCard(
                    achievement: achievements[index],
                    index: index,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Premium achievement card with animated counter and glow effect
class _PremiumAchievementCard extends StatefulWidget {
  final Achievement achievement;
  final int index;

  const _PremiumAchievementCard(
      {required this.achievement, required this.index});

  @override
  State<_PremiumAchievementCard> createState() =>
      _PremiumAchievementCardState();
}

class _PremiumAchievementCardState extends State<_PremiumAchievementCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _counterAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _counterAnimation = Tween<double>(
      begin: 0,
      end: widget.achievement.value.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBorderContainer(
      padding: EdgeInsets.zero,
      child: PremiumGlassCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with glow
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.2),
                          AppTheme.secondaryColor.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      widget.achievement.icon,
                      size: 48,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Animated counter
            AnimatedBuilder(
              animation: _counterAnimation,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.auroraGradient1.createShader(
                    bounds,
                    textDirection: TextDirection.ltr,
                  ),
                  child: Text(
                    '${_counterAnimation.value.toInt()}${widget.achievement.suffix}',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Label
            Text(
              widget.achievement.label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: (widget.index * 150).ms).slideY(
          begin: 0.2,
          end: 0,
          duration: 600.ms,
        );
  }
}
