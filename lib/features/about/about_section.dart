import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/premium_glass_card.dart';
import '../../core/widgets/gradient_border_container.dart';

/// Premium About Section with modern layout and animations
/// Inspired by Linear and Vercel about pages
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (size.width > 1200 ? 120 : 24),
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: 'About Me',
            subtitle:
                'Passionate about crafting exceptional digital experiences',
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Profile with gradient border
                    Expanded(
                      flex: 1,
                      child: _buildProfileCard(context),
                    ),

                    const SizedBox(width: 64),

                    // Right side - Content
                    Expanded(
                      flex: 2,
                      child: _buildContent(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildProfileCard(context),
                    const SizedBox(height: 48),
                    _buildContent(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return GradientBorderContainer(
      padding: EdgeInsets.zero,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              AppTheme.secondaryColor.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/shubham.png',
              width: 300,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3, end: 0);
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Introduction
        Text(
          'Professional Introduction',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textColor,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms),

        const SizedBox(height: 24),

        Text(
          'I am a passionate Senior Flutter Developer with over 6+ years of experience in building beautiful, scalable, and high-performance cross-platform applications. My expertise lies in creating mobile apps that provide exceptional user experiences while maintaining clean architecture and best practices.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondaryColor,
            height: 1.6,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 300.ms),

        const SizedBox(height: 40),

        // Info cards grid
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _PremiumInfoCard(
              icon: Icons.work,
              title: 'Experience',
              value: '6+ Years',
              gradient: AppTheme.auroraGradient1,
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
            _PremiumInfoCard(
              icon: Icons.location_on,
              title: 'Location',
              value: 'Pune, India',
              gradient: AppTheme.auroraGradient2,
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
            _PremiumInfoCard(
              icon: Icons.schedule,
              title: 'Availability',
              value: 'Immediate',
              gradient: AppTheme.auroraGradient3,
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
          ],
        ),

        const SizedBox(height: 48),

        // Career summary
        Text(
          'Career Summary',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textColor,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 700.ms),

        const SizedBox(height: 24),

        PremiumGlassCard(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Throughout my career, I have worked on diverse projects ranging from dating apps to healthcare platforms. I specialize in Flutter development, Firebase integration, state management (GetX, Riverpod, Bloc, Provider), and implementing clean architecture patterns. I am committed to writing clean, maintainable code and staying updated with the latest technologies and best practices.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondaryColor,
              height: 1.8,
            ),
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
      ],
    );
  }
}

/// Premium info card with gradient icon
class _PremiumInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final LinearGradient gradient;

  const _PremiumInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.gradient,
  });

  @override
  State<_PremiumInfoCard> createState() => _PremiumInfoCardState();
}

class _PremiumInfoCardState extends State<_PremiumInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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

    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: PremiumGlassCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: widget.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      Text(
                        widget.value,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
