import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/premium_glass_card.dart';
import '../../models/skill.dart';

/// Premium Skills Section with floating bubbles and interactive animations
/// Inspired by Linear and Vercel interactive skill displays
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final categories = ['All', ...SkillsData.categories];
    final filteredSkills = _selectedCategory == 'All'
        ? SkillsData.skills
        : SkillsData.getSkillsByCategory(_selectedCategory);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200 ? 120 : 24,
        vertical: 100,
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Skills & Technologies',
            subtitle: 'Expertise in modern development stack',
          ),

          const SizedBox(height: 48),

          // Premium category filter
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: categories.map((category) {
              final isSelected = category == _selectedCategory;
              return _SkillCategoryChip(
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

          // Skills grid with floating bubbles
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = size.width > 1200
                  ? 4
                  : size.width > 800
                      ? 3
                      : size.width > 600
                          ? 2
                          : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
                itemCount: filteredSkills.length,
                itemBuilder: (context, index) {
                  return _FloatingSkillBubble(
                    skill: filteredSkills[index],
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

/// Premium category chip with animated selection
class _SkillCategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SkillCategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_SkillCategoryChip> createState() => _SkillCategoryChipState();
}

class _SkillCategoryChipState extends State<_SkillCategoryChip>
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
                color:
                    widget.isSelected ? null : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.isSelected
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.1),
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

/// Floating skill bubble with hover effects
class _FloatingSkillBubble extends StatefulWidget {
  final Skill skill;
  final int index;

  const _FloatingSkillBubble({
    required this.skill,
    required this.index,
  });

  @override
  State<_FloatingSkillBubble> createState() => _FloatingSkillBubbleState();
}

class _FloatingSkillBubbleState extends State<_FloatingSkillBubble>
    with SingleTickerProviderStateMixin {
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
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with glow effect
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.2),
                          AppTheme.secondaryColor.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.skill.icon,
                      style: const TextStyle(fontSize: 40),
                    ),
                  )
                      .animate()
                      .scale(duration: 400.ms, delay: (widget.index * 50).ms),

                  const SizedBox(height: 16),

                  // Name
                  Text(
                    widget.skill.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textColor,
                    ),
                  ).animate().fadeIn(
                      duration: 400.ms, delay: (widget.index * 50 + 100).ms),

                  const SizedBox(height: 8),

                  // Category
                  Text(
                    widget.skill.category,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ).animate().fadeIn(
                      duration: 400.ms, delay: (widget.index * 50 + 150).ms),

                  const SizedBox(height: 16),

                  // Proficiency indicator
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${widget.skill.proficiency}% Proficiency',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(
                      duration: 400.ms, delay: (widget.index * 50 + 200).ms),
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
}
