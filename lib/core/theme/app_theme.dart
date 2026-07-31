import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Premium App Theme Configuration
/// Inspired by Linear, Vercel, Apple, and other world-class designs
/// Features Aurora gradients, Glassmorphism, and modern aesthetics
class AppTheme {
  AppTheme._();

  // ===== PREMIUM DARK THEME COLORS =====
  static const Color _darkBackground = Color(0xFF030014);
  static const Color _darkSurface = Color(0xFF0A0A1A);
  static const Color _darkSurfaceVariant = Color(0xFF12122A);
  static const Color _darkCard = Color(0xFF1A1A2E);

  static const Color _darkPrimary = Color(0xFF6366F1);
  static const Color _darkPrimaryGlow = Color(0x336366F1);

  static const Color _darkSecondary = Color(0xFF8B5CF6);

  static const Color _darkAccent = Color(0xFF06B6D4);

  static const Color _darkPink = Color(0xFFEC4899);

  static const Color _darkText = Color(0xFFE2E8F0);
  static const Color _darkTextSecondary = Color(0xFF94A3B8);

  static const Color _darkBorder = Color(0x1FFFFFFF);

  static const Color _darkGlass = Color(0x0AFFFFFF);

  // ===== PREMIUM LIGHT THEME COLORS =====
  static const Color _lightBackground = Color(0xFFFAFAFA);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightSurfaceVariant = Color(0xFFF8FAFC);
  static const Color _lightCard = Color(0xFFFFFFFF);

  static const Color _lightPrimary = Color(0xFF4F46E5);
  static const Color _lightPrimaryGlow = Color(0x1A4F46E5);

  static const Color _lightSecondary = Color(0xFF7C3AED);

  static const Color _lightPink = Color(0xFFDB2777);

  static const Color _lightText = Color(0xFF0F172A);
  static const Color _lightTextSecondary = Color(0xFF475569);

  static const Color _lightBorder = Color(0x0A0F172A);

  static const Color _lightGlass = Color(0x6AFFFFFF);

  // ===== AURORA GRADIENTS =====
  static const List<Color> _auroraGradient1 = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
  ];

  static const List<Color> _auroraGradient2 = [
    Color(0xFF06B6D4),
    Color(0xFF3B82F6),
    Color(0xFF6366F1),
  ];

  static const List<Color> _auroraGradient3 = [
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF6366F1),
  ];

  static const List<Color> _auroraGradient4 = [
    Color(0xFF10B981),
    Color(0xFF06B6D4),
    Color(0xFF3B82F6),
  ];

  // ===== GRADIENT GETTERS =====

  /// Primary Aurora Gradient
  static LinearGradient get auroraGradient1 {
    return const LinearGradient(
      colors: _auroraGradient1,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  /// Secondary Aurora Gradient
  static LinearGradient get auroraGradient2 {
    return const LinearGradient(
      colors: _auroraGradient2,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );
  }

  /// Pink Aurora Gradient
  static LinearGradient get auroraGradient3 {
    return const LinearGradient(
      colors: _auroraGradient3,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  /// Green Aurora Gradient
  static LinearGradient get auroraGradient4 {
    return const LinearGradient(
      colors: _auroraGradient4,
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );
  }

  /// Mesh Gradient Background
  static LinearGradient get meshGradient {
    return const LinearGradient(
      colors: [
        Color(0xFF030014),
        Color(0xFF0A0A1A),
        Color(0xFF12122A),
        Color(0xFF0A0A1A),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.3, 0.7, 1.0],
    );
  }

  // ===== GLASSMORPHISM EFFECTS =====

  /// Dark Glassmorphism Card
  static BoxDecoration darkGlassCard({
    double blur = 20,
    double opacity = 0.1,
    double borderOpacity = 0.1,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: _darkGlass.withOpacity(opacity),
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: Colors.white.withOpacity(borderOpacity),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: _darkPrimaryGlow,
          blurRadius: blur,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Light Glassmorphism Card
  static BoxDecoration lightGlassCard({
    double blur = 20,
    double opacity = 0.7,
    double borderOpacity = 0.2,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: _lightGlass.withOpacity(opacity),
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: Colors.black.withOpacity(borderOpacity),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: _lightPrimaryGlow,
          blurRadius: blur,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Premium Card with Gradient Border
  static BoxDecoration premiumCard({
    required bool isDark,
    List<Color>? gradientColors,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          isDark ? _darkCard : _lightCard,
          isDark ? _darkCard : _lightCard,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.1),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: (isDark ? _darkPrimary : _lightPrimary).withOpacity(0.1),
          blurRadius: 40,
          offset: const Offset(0, 20),
        ),
      ],
    );
  }

  // ===== THEME DATA =====

  /// Premium Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: _lightPrimary,
        onPrimary: Colors.white,
        secondary: _lightSecondary,
        onSecondary: Colors.white,
        tertiary: _lightPink,
        onTertiary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: _lightBackground,
        onBackground: _lightText,
        surface: _lightSurface,
        onSurface: _lightText,
        surfaceVariant: _lightSurfaceVariant,
        outline: _lightTextSecondary,
      ),
      scaffoldBackgroundColor: _lightBackground,
      textTheme: _getTextTheme(false),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _lightText,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: _lightPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: _lightPrimary),
      dividerTheme: DividerThemeData(
        color: _lightBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Premium Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: _darkPrimary,
        onPrimary: Colors.white,
        secondary: _darkSecondary,
        onSecondary: Colors.white,
        tertiary: _darkPink,
        onTertiary: Colors.white,
        error: Colors.red.shade400,
        onError: Colors.white,
        background: _darkBackground,
        onBackground: _darkText,
        surface: _darkSurface,
        onSurface: _darkText,
        surfaceVariant: _darkSurfaceVariant,
        outline: _darkTextSecondary,
      ),
      scaffoldBackgroundColor: _darkBackground,
      textTheme: _getTextTheme(true),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _darkText,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: _darkPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: _darkPrimary),
      dividerTheme: DividerThemeData(
        color: _darkBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // ===== TEXT THEME =====

  static TextTheme _getTextTheme(bool isDark) {
    final textColor = isDark ? _darkText : _lightText;
    final textSecondary = isDark ? _darkTextSecondary : _lightTextSecondary;

    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 96,
        fontWeight: FontWeight.w700,
        letterSpacing: -3,
        color: textColor,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
        color: textColor,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 56,
        fontWeight: FontWeight.w600,
        letterSpacing: -1.5,
        color: textColor,
        height: 1.2,
      ),
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
        color: textColor,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: textColor,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.3,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: textColor,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }

  // ===== COLOR ACCESSORS =====

  static Color get primaryColor => _darkPrimary;
  static Color get secondaryColor => _darkSecondary;
  static Color get accentColor => _darkAccent;
  static Color get pinkColor => _darkPink;
  static Color get textColor => _darkText;
  static Color get textSecondaryColor => _darkTextSecondary;
  static Color get backgroundColor => _darkBackground;
  static Color get surfaceColor => _darkSurface;
  static Color get cardColor => _darkCard;

  // Legacy getters for compatibility
  static LinearGradient get gradient => auroraGradient1;
  static BoxDecoration get glassmorphism => darkGlassCard();
}
