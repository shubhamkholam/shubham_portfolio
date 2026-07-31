import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/premium_button.dart';
import '../../core/widgets/premium_glass_card.dart';

/// Premium Contact Section with glass form and animated interactions
/// Inspired by Linear and Vercel contact pages
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final subject = _subjectController.text.trim();
      final message = _messageController.text.trim();

      // Formspree endpoint - replace with your actual form ID
      // Get your form ID from https://formspree.io/
      const formId = 'mdaqvyze';
      final url = Uri.parse('https://formspree.io/f/$formId');

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': name,
            'email': email,
            'subject': subject,
            'message': message,
          }),
        );

        setState(() => _isSubmitting = false);

        if (mounted) {
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Message sent successfully!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            _formKey.currentState!.reset();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    const Text('Failed to send message. Please try again.'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      } catch (e) {
        setState(() => _isSubmitting = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error sending message. Please try again.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

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
            title: 'Contact',
            subtitle: 'Let\'s create something amazing together',
          ),
          SizedBox(height: isMobile ? 32 : 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact info
                    Expanded(
                      flex: 1,
                      child: _buildContactInfo(context),
                    ),

                    const SizedBox(width: 64),

                    // Contact form
                    Expanded(
                      flex: 2,
                      child: _buildContactForm(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildContactInfo(context),
                    SizedBox(height: isMobile ? 32 : 48),
                    _buildContactForm(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.auroraGradient1.createShader(
            bounds,
            textDirection: TextDirection.ltr,
          ),
          child: Text(
            'Get in Touch',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn(duration: 600.ms),
        ),

        const SizedBox(height: 24),

        Text(
          'I\'m currently available for freelance work and full-time opportunities. If you have a project that you want to get started or think you need my help with something, then get in touch.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondaryColor,
            height: 1.6,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

        const SizedBox(height: 40),

        _PremiumContactInfo(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'shubhamkholam@gmail.com',
          url: 'mailto:shubhamkholam@gmail.com',
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

        const SizedBox(height: 24),

        _PremiumContactInfo(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: '+91 70209 39720',
          url: 'tel:+917020939720',
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

        const SizedBox(height: 24),

        _PremiumContactInfo(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: 'Pune, Maharashtra, India',
          url: 'https://maps.google.com/?q=Pune,Maharashtra,India',
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),

        const SizedBox(height: 40),

        // Availability badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: AppTheme.auroraGradient2,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Available for work',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

        const SizedBox(height: 40),

        // Social links
        Text(
          'Connect with me',
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textColor,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 700.ms),

        const SizedBox(height: 20),

        Row(
          children: [
            _PremiumSocialButton(
              icon: Icons.link,
              url: 'https://linkedin.com/in/shubham-kholam-333889159',
              label: 'LinkedIn',
            ),
            const SizedBox(width: 16),
            _PremiumSocialButton(
              icon: Icons.code,
              url: 'https://github.com/shubhamkholam',
              label: 'GitHub',
            ),
            const SizedBox(width: 16),
            _PremiumSocialButton(
              icon: Icons.chat_outlined,
              url: 'https://wa.me/+917020939720',
              label: 'WhatsApp',
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return PremiumGlassCard(
      padding: const EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              delay: 200,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              delay: 300,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _subjectController,
              label: 'Subject',
              icon: Icons.subject_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
              delay: 400,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              icon: Icons.message_outlined,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
              delay: 500,
            ),
            const SizedBox(height: 32),
            PremiumButton(
              text: _isSubmitting ? 'Sending...' : 'Send Message',
              icon: _isSubmitting ? null : Icons.send,
              onPressed: _isSubmitting ? null : _submitForm,
              width: double.infinity,
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    required String? Function(String?) validator,
    required int delay,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(color: AppTheme.textColor),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
  }
}

/// Premium contact info widget
class _PremiumContactInfo extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;

  const _PremiumContactInfo({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  @override
  State<_PremiumContactInfo> createState() => _PremiumContactInfoState();
}

class _PremiumContactInfoState extends State<_PremiumContactInfo>
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

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
            child: GestureDetector(
              onTap: _launchUrl,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _controller.status == AnimationStatus.forward ||
                          _controller.status == AnimationStatus.completed
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _controller.status == AnimationStatus.forward ||
                            _controller.status == AnimationStatus.completed
                        ? AppTheme.primaryColor.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: _controller.status ==
                                    AnimationStatus.forward ||
                                _controller.status == AnimationStatus.completed
                            ? AppTheme.auroraGradient1
                            : null,
                        color: _controller.status == AnimationStatus.forward ||
                                _controller.status == AnimationStatus.completed
                            ? null
                            : AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              _controller.status == AnimationStatus.forward ||
                                      _controller.status ==
                                          AnimationStatus.completed
                                  ? Colors.transparent
                                  : Colors.white.withOpacity(0.1),
                          width: 1.5,
                        ),
                        boxShadow: _controller.status ==
                                    AnimationStatus.forward ||
                                _controller.status == AnimationStatus.completed
                            ? [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        widget.icon,
                        color: _controller.status == AnimationStatus.forward ||
                                _controller.status == AnimationStatus.completed
                            ? Colors.white
                            : AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.label,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.value,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: _controller.status == AnimationStatus.forward ||
                              _controller.status == AnimationStatus.completed
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondaryColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Premium social button widget
class _PremiumSocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;

  const _PremiumSocialButton({
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  State<_PremiumSocialButton> createState() => _PremiumSocialButtonState();
}

class _PremiumSocialButtonState extends State<_PremiumSocialButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
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
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: _launchUrl,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: _controller.status == AnimationStatus.forward ||
                          _controller.status == AnimationStatus.completed
                      ? AppTheme.auroraGradient1
                      : null,
                  color: _controller.status == AnimationStatus.forward ||
                          _controller.status == AnimationStatus.completed
                      ? null
                      : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _controller.status == AnimationStatus.forward ||
                            _controller.status == AnimationStatus.completed
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                  boxShadow: _controller.status == AnimationStatus.forward ||
                          _controller.status == AnimationStatus.completed
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  widget.icon,
                  color: _controller.status == AnimationStatus.forward ||
                          _controller.status == AnimationStatus.completed
                      ? Colors.white
                      : AppTheme.textSecondaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
