import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:html' as html;
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../models/project.dart';

/// Premium Projects Section with interactive showcases
/// Inspired by Linear, Vercel, and Dribbble project showcases
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final categories = ['All', ...ProjectsData.categories];
    final filteredProjects = _selectedCategory == 'All'
        ? ProjectsData.projects
        : ProjectsData.getProjectsByCategory(_selectedCategory);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200 ? 120.w : 24.w,
        vertical: 100.h,
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Featured Projects',
            subtitle:
                'Crafting digital experiences with precision and creativity',
          ),

          const SizedBox(height: 48),

          // Premium category filter
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: categories.map((category) {
              final isSelected = category == _selectedCategory;
              return _CategoryChip(
                label: category,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 64),

          // Projects grid with premium cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = size.width > 1200;

              if (isDesktop) {
                // Desktop: Horizontal scrolling cards
                return SizedBox(
                  height: 500.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 32.w),
                        child: SizedBox(
                          width: 420.w,
                          child: _PremiumProjectCard(
                            project: filteredProjects[index],
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                // Mobile: Vertical cards
                return Column(
                  children: filteredProjects.asMap().entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: _PremiumProjectCard(
                        project: entry.value,
                        index: entry.key,
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Premium Category Chip with animated selection
class _CategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: widget.isSelected ? AppTheme.auroraGradient1 : null,
                color: widget.isSelected
                    ? null
                    : (isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.black.withOpacity(0.03)),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.isSelected
                      ? Colors.transparent
                      : (isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1)),
                  width: 1.5,
                ),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                widget.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: widget.isSelected
                      ? Colors.white
                      : AppTheme.textSecondaryColor,
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

/// Premium Project Card with magnetic hover and animated overlay
class _PremiumProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const _PremiumProjectCard({
    required this.project,
    required this.index,
  });

  @override
  State<_PremiumProjectCard> createState() => _PremiumProjectCardState();
}

class _PremiumProjectCardState extends State<_PremiumProjectCard>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;

    return GestureDetector(
      onTap: () {},
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: isDesktop ? 420.w : double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project screenshot
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.15),
                          AppTheme.secondaryColor.withOpacity(0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.apps_outlined,
                            size: 48.r,
                            color: AppTheme.primaryColor.withOpacity(0.6),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Project Preview',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppTheme.primaryColor.withOpacity(0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.project.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textColor,
                            fontSize: 22.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 12.h),

                        // Description
                        Text(
                          widget.project.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 16.sp,
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 16.h),

                        // Tech stack chips
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children:
                              widget.project.techStack.take(4).map((tech) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppTheme.primaryColor.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                tech,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 20.h),

                        // Action buttons
                        Row(
                          children: [
                            if (widget.project.playStoreLink != null)
                              _ActionButton(
                                icon: Icons.android,
                                label: 'Play Store',
                                onTap: () =>
                                    _launchUrl(widget.project.playStoreLink!),
                                isMobile: false,
                              ),
                            if (widget.project.playStoreLink != null &&
                                widget.project.appStoreLink != null)
                              SizedBox(width: 12.w),
                            if (widget.project.appStoreLink != null)
                              _ActionButton(
                                icon: Icons.apple_sharp,
                                label: 'App Store',
                                onTap: () =>
                                    _launchUrl(widget.project.appStoreLink!),
                                isMobile: false,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 600.ms, delay: (widget.index * 100).ms).slideY(
          begin: 0.2,
          end: 0,
        );
  }

  Future<void> _launchUrl(String url) async {
    debugPrint('Launching URL: $url');
    // For web, use window.open to ensure it opens in new tab
    html.window.open(url, '_blank');
  }
}

/// Action button for project card
class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isMobile;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isMobile = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color:
                    _isHovered ? null : AppTheme.primaryColor.withOpacity(0.1),
                gradient: _isHovered ? AppTheme.auroraGradient1 : null,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _isHovered
                      ? Colors.transparent
                      : AppTheme.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 18.r,
                    color: _isHovered ? Colors.white : AppTheme.primaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _isHovered ? Colors.white : AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
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
