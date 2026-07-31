import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/premium_button.dart';
import '../../core/widgets/gradient_border_container.dart';
import '../../core/widgets/scroll_indicator.dart';

/// Premium Hero Section with breathtaking animations
/// Inspired by Linear, Vercel, and Apple hero sections
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.95,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 1200;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isDesktop) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left side - Text content
                        Expanded(
                          flex: 1,
                          child: _buildTextContent(context, theme),
                        ),
                        const SizedBox(width: 64),
                        // Right side - Profile image with glow
                        Expanded(
                          flex: 1,
                          child: _buildProfileImage(context, theme),
                        ),
                      ],
                    ),
                  ] else ...[
                    // Mobile/Tablet - Stacked layout
                    _buildProfileImage(context, theme),
                    const SizedBox(height: 48),
                    _buildTextContent(context, theme),
                  ],
                  const SizedBox(height: 64),
                  // CTA Buttons
                  _buildCTAButtons(context, theme),
                  const SizedBox(height: 48),
                  // Social icons
                  _buildSocialIcons(context, theme),
                  const SizedBox(height: 48),
                  // Scroll indicator
                  const ScrollIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting with reveal animation
        Text(
          'Hello, I\'m',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),

        const SizedBox(height: 16),

        // Name with gradient text
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.auroraGradient1.createShader(
            bounds,
            textDirection: TextDirection.ltr,
          ),
          child: Text(
            'Shubham Kholam',
            style: theme.textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 200.ms)
              .slideX(begin: -0.3),
        ),

        const SizedBox(height: 24),

        // Animated role text
        SizedBox(
          height: 48,
          child: DefaultTextStyle(
            style: theme.textTheme.headlineSmall!.copyWith(
              color: AppTheme.textSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Senior Flutter Developer'),
                TypewriterAnimatedText('Cross-Platform Expert'),
                TypewriterAnimatedText('Clean Architecture Advocate'),
                TypewriterAnimatedText('Mobile App Architect'),
              ],
              repeatForever: true,
              pause: const Duration(milliseconds: 2000),
              displayFullTextOnTap: false,
              stopPauseOnTap: false,
            ),
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

        const SizedBox(height: 32),

        // Tagline
        SizedBox(
          width: 600,
          child: Text(
            'Building beautiful, scalable, high-performance cross-platform applications using Flutter and modern development practices.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondaryColor,
              height: 1.6,
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, ThemeData theme) {
    return Center(
      child: GradientBorderContainer(
        width: 400,
        height: 400,
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.auroraGradient2,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.cardColor,
              ),
              child: Icon(
                Icons.person,
                size: 150,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ),
      ).animate().scale(duration: 1000.ms, curve: Curves.elasticOut),
    );
  }

  Widget _buildCTAButtons(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PremiumButton(
          text: 'Download Resume',
          icon: Icons.download,
          onPressed: () {
            // TODO: Implement resume download
          },
        ),
        const SizedBox(width: 24),
        PremiumButton(
          text: 'Contact Me',
          icon: Icons.send,
          isPrimary: false,
          onPressed: () {
            // Scroll to contact section
          },
        ),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 800.ms);
  }

  Widget _buildSocialIcons(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: Icons.link,
          url: 'https://linkedin.com/in/shubhamkholam',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: Icons.code,
          url: 'https://github.com/shubhamkholam',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: Icons.email,
          url: 'mailto:shubham@example.com',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: Icons.phone,
          url: 'tel:+919876543210',
        ),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 1000.ms);
  }
}

/// Premium Social Icon with hover effects
class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon>
    with SingleTickerProviderStateMixin {
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isHovered
                      ? [
                          AppTheme.primaryColor,
                          AppTheme.secondaryColor,
                        ]
                      : [
                          isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.05),
                          isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.02),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isHovered
                      ? AppTheme.primaryColor.withOpacity(0.5)
                      : (isDark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1)),
                  width: 1.5,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: IconButton(
                icon: Icon(
                  widget.icon,
                  color: _isHovered
                      ? Colors.white
                      : (isDark
                          ? AppTheme.textSecondaryColor
                          : AppTheme.textSecondaryColor),
                ),
                onPressed: _launchUrl,
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 600.ms).scale();
  }
}
