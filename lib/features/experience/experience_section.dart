import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_header.dart';
import '../../models/experience.dart';

/// Premium Experience Section with horizontal scrolling cards
/// Modern card-based layout for better UX
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200 ? 120.w : 16.w,
        vertical: 100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Experience',
            subtitle: 'A journey through my professional growth',
          ),

          SizedBox(height: 48.h),

          // Horizontal scrolling experience cards
          _HorizontalExperienceCards(experiences: ExperienceData.experiences),
        ],
      ),
    );
  }
}

/// Horizontal scrolling experience cards
class _HorizontalExperienceCards extends StatelessWidget {
  final List<Experience> experiences;

  const _HorizontalExperienceCards({required this.experiences});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: _ExperienceCard(
              experience: experiences[index],
              index: index,
            ),
          );
        },
      ),
    );
  }
}

/// Modern experience card
class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final int index;

  const _ExperienceCard({
    required this.experience,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width > 768 ? 380.w : 320.w;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company logo placeholder
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                gradient: AppTheme.auroraGradient1,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text(
                  experience.company[0],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Company name
            Text(
              experience.company,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textColor,
                fontSize: 20.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8.h),

            // Role
            Text(
              experience.role,
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 16.h),

            // Location and duration
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.r,
                  color: AppTheme.textSecondaryColor,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    experience.location,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.r,
                  color: AppTheme.textSecondaryColor,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '${experience.startDate} - ${experience.endDate ?? 'Present'}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Current badge
            if (experience.isCurrent)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  gradient: AppTheme.auroraGradient2,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Current',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: (index * 150).ms).slideX(
          begin: 0.2,
          end: 0,
        );
  }
}
