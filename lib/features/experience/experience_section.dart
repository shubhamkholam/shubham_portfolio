import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/premium_glass_card.dart';
import '../../models/experience.dart';

/// Premium Experience Section with expandable cards and animated timeline
/// Inspired by Linear and Vercel career pages
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
            title: 'Experience',
            subtitle: 'A journey through my professional growth',
          ),

          const SizedBox(height: 64),

          // Premium timeline
          _PremiumTimeline(experiences: ExperienceData.experiences),
        ],
      ),
    );
  }
}

/// Premium timeline widget
class _PremiumTimeline extends StatelessWidget {
  final List<Experience> experiences;

  const _PremiumTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final experience = entry.value;
        final isLast = index == experiences.length - 1;

        return Column(
          children: [
            _PremiumTimelineItem(
              experience: experience,
              isLast: isLast,
              index: index,
            ),
            if (!isLast) const SizedBox(height: 32),
          ],
        );
      }).toList(),
    );
  }
}

/// Premium timeline item widget
class _PremiumTimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;
  final int index;

  const _PremiumTimelineItem({
    required this.experience,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Animated timeline line and dot
        SizedBox(
          width: 60,
          child: Column(
            children: [
              // Glowing dot
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  gradient: AppTheme.auroraGradient1,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ).animate().scale(duration: 500.ms, delay: (index * 200).ms),

              // Gradient line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.primaryColor.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ).animate().fadeIn(
                        duration: 500.ms,
                        delay: (index * 200 + 100).ms,
                      ),
                ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: _PremiumExperienceCard(
            experience: experience,
            index: index,
          ),
        ),

        const SizedBox(width: 60),
      ],
    );
  }
}

/// Premium expandable experience card
class _PremiumExperienceCard extends StatefulWidget {
  final Experience experience;
  final int index;

  const _PremiumExperienceCard({
    required this.experience,
    required this.index,
  });

  @override
  State<_PremiumExperienceCard> createState() => _PremiumExperienceCardState();
}

class _PremiumExperienceCardState extends State<_PremiumExperienceCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PremiumGlassCard(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with company, role, and expand button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.experience.company,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.experience.role,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.experience.isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.auroraGradient1,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Current',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              // Expand/collapse button
              GestureDetector(
                onTap: _toggleExpand,
                child: AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.expand_more,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms, delay: (widget.index * 200).ms),

          const SizedBox(height: 16),

          // Location and duration
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppTheme.textSecondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                widget.experience.location,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(width: 24),
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: AppTheme.textSecondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.experience.startDate} - ${widget.experience.endDate ?? 'Present'}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ).animate().fadeIn(
                duration: 500.ms,
                delay: (widget.index * 200 + 100).ms,
              ),

          const SizedBox(height: 24),

          // Expandable content
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: -1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Responsibilities
                Text(
                  'Responsibilities',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...widget.experience.responsibilities.map((responsibility) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            responsibility,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondaryColor,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                const SizedBox(height: 24),

                // Achievements
                Text(
                  'Key Achievements',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...widget.experience.achievements.map((achievement) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: AppTheme.accentColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            achievement,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondaryColor,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: (widget.index * 200).ms).slideX(
          begin: 0.2,
          end: 0,
          duration: 500.ms,
        );
  }
}
