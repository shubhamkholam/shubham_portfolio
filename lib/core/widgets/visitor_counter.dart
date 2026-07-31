import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:html' as html;
import '../../core/theme/app_theme.dart';

/// Visitor Counter Widget that tracks and displays site visits locally
class VisitorCounter extends StatefulWidget {
  const VisitorCounter({super.key});

  @override
  State<VisitorCounter> createState() => _VisitorCounterState();
}

class _VisitorCounterState extends State<VisitorCounter> {
  int _visitorCount = 550;
  bool _isLoading = true;

  static const String _storageKey = 'shubham_portfolio_visitor_count';

  @override
  void initState() {
    super.initState();
    _loadAndIncrementVisitorCount();
  }

  void _loadAndIncrementVisitorCount() {
    try {
      // Get current count from localStorage
      final storedCount = html.window.localStorage[_storageKey];
      int currentCount =
          storedCount != null ? int.tryParse(storedCount) ?? 0 : 0;

      // Increment count
      currentCount++;

      // Save back to localStorage
      html.window.localStorage[_storageKey] = currentCount.toString();

      setState(() {
        _visitorCount = currentCount;
        _isLoading = false;
      });
    } catch (e) {
      // If localStorage fails, use a default count
      setState(() {
        _visitorCount = 1;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
          Icon(
            Icons.visibility_outlined,
            color: Colors.white,
            size: 20,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(width: 12),
          if (_isLoading)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_visitorCount',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ).animate().fadeIn(duration: 600.ms),
                Text(
                  'Visitors',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              ],
            ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}
