import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'premium_navbar.dart';

/// Footer component with links and copyright
class Footer extends StatelessWidget {
  final ScrollController scrollController;
  final List<NavItem> items;

  const Footer({
    super.key,
    required this.scrollController,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 48,
        horizontal: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
      ),
      child: Column(
        children: [
          // Logo and tagline
          Column(
            children: [
              Text(
                'Shubham Kholam',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 8),
              Text(
                'Senior Flutter Developer',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            ],
          ),

          const SizedBox(height: 32),

          // Navigation links
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _FooterLink(
                label: 'Home',
                onTap: () => _scrollToSection('home'),
              ),
              _FooterLink(
                label: 'About',
                onTap: () => _scrollToSection('about'),
              ),
              _FooterLink(
                label: 'Skills',
                onTap: () => _scrollToSection('skills'),
              ),
              _FooterLink(
                label: 'Experience',
                onTap: () => _scrollToSection('experience'),
              ),
              _FooterLink(
                label: 'Projects',
                onTap: () => _scrollToSection('projects'),
              ),
              _FooterLink(
                label: 'Contact',
                onTap: () => _scrollToSection('contact'),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

          const SizedBox(height: 32),

          // Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(
                icon: Icons.link,
                url: 'https://www.linkedin.com/in/shubham-kholam-333889159/',
                label: 'LinkedIn',
              ),
              const SizedBox(width: 16),
              _SocialIcon(
                icon: Icons.code,
                url: 'https://github.com/shubhamkholam',
                label: 'GitHub',
              ),
              const SizedBox(width: 16),
              _SocialIcon(
                icon: Icons.email,
                url: 'mailto:shubhamkholam@gmail.com',
                label: 'Email',
              ),
              const SizedBox(width: 16),
              _SocialIcon(
                icon: Icons.chat,
                url: 'https://wa.me/+917020939720',
                label: 'WhatsApp',
              ),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

          const SizedBox(height: 32),

          // Copyright
          Text(
            '© 2026 Shubham Kholam. All rights reserved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 500.ms),

          const SizedBox(height: 8),

          Text(
            'Built with Flutter ❤️',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
        ],
      ),
    );
  }

  void _scrollToSection(String sectionId) {
    final item = items.firstWhere(
      (item) => item.id == sectionId,
      orElse: () => items.first,
    );
    debugPrint('Scrolling to section: $sectionId');
    debugPrint('Item key context: ${item.key.currentContext}');

    if (item.key.currentContext != null) {
      // Try using Scrollable.ensureVisible first
      try {
        Scrollable.ensureVisible(
          item.key.currentContext!,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      } catch (e) {
        debugPrint('Error with Scrollable.ensureVisible: $e');
        // Fallback: scroll to approximate position
        final index = items.indexWhere((i) => i.id == sectionId);
        if (index >= 0) {
          final offset = index * 600.0; // Approximate section height
          scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    } else {
      debugPrint('Context is null for section: $sectionId');
      // Fallback: scroll to approximate position
      final index = items.indexWhere((i) => i.id == sectionId);
      if (index >= 0) {
        final offset = index * 600.0;
        scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }
}

/// Footer link widget
class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}

/// Social icon widget
class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final String label;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.label,
  });

  Future<void> _launchUrl() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: label,
      child: InkWell(
        onTap: _launchUrl,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
