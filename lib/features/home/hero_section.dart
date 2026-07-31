import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:html' as html;
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

    return SizedBox(
      height: 1.4.sh,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 100.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 1200.w;

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
                        SizedBox(width: 64.w),
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
                    SizedBox(height: 48.h),
                    _buildTextContent(context, theme),
                  ],
                  SizedBox(height: 64.h),
                  // CTA Buttons
                  _buildCTAButtons(context, theme),
                  SizedBox(height: 48.h),
                  // Social icons
                  _buildSocialIcons(context, theme),
                  SizedBox(height: 48.h),
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
            fontSize: 24.sp,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),

        SizedBox(height: 16.h),

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
              fontSize: 48.sp,
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 200.ms)
              .slideX(begin: -0.3),
        ),

        SizedBox(height: 24.h),

        // Animated role text
        SizedBox(
          height: 48.h,
          child: DefaultTextStyle(
            style: theme.textTheme.headlineSmall!.copyWith(
              color: AppTheme.textSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
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

        SizedBox(height: 32.h),

        // Tagline
        SizedBox(
          width: 600.w,
          child: Text(
            'Building beautiful, scalable, high-performance cross-platform applications using Flutter and modern development practices.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondaryColor,
              height: 1.6,
              fontSize: 16.sp,
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
              child: ClipOval(
                child: Image.asset(
                  'assets/images/shubham.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
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
          onPressed: () async {
            await _downloadResume();
          },
        ),
        SizedBox(width: 16.w),
        PremiumButton(
          text: 'Contact Me',
          icon: Icons.mail,
          isPrimary: false,
          onPressed: () {
            // Scroll to contact section
          },
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms);
  }

  Future<void> _downloadResume() async {
    try {
      // Load the resume asset
      final byteData =
          await rootBundle.load('assets/resume/shubham_kholam.pdf');
      final bytes = byteData.buffer.asUint8List();

      // Create blob and download link for web
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'shubham_kholam.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint('Error downloading resume: $e');
    }
  }

  Widget _buildSocialIcons(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: Icons.link,
          url: 'https://www.linkedin.com/in/shubham-kholam-333889159/',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: Icons.code,
          url: 'https://github.com/shubhamkholam',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: Icons.email,
          url: 'mailto:shubhamkholam@gmail.com',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: Icons.phone,
          url: 'tel:+917020939720',
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
