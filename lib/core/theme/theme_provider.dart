import 'package:flutter/material.dart';

/// Theme Provider for managing app theme state
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    // For web, we'll default to dark mode preference
    return _themeMode == ThemeMode.dark;
  }

  ThemeProvider() {
    // Initialize with dark mode
    _themeMode = ThemeMode.dark;
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
