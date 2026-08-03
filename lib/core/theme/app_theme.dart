import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark() {
    const background = Color(0xFF081018);
    const surface = Color(0xFF0F1A24);
    const surfaceVariant = Color(0xFF132333);
    const accent = Color(0xFF7BE0B1);
    const accentWarm = Color(0xFFFFC857);

    final colorScheme = const ColorScheme.dark(
      primary: accent,
      secondary: accentWarm,
      surface: surface,
      onSurface: Colors.white,
      onPrimary: Color(0xFF061018),
      onSecondary: Color(0xFF061018),
      error: Color(0xFFFF6B6B),
      onError: Colors.white,
    ).copyWith(surfaceContainerHighest: surfaceVariant);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: accent.withValues(alpha: 0.16),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, height: 1.05),
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, height: 1.05),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 15, height: 1.4),
        bodyMedium: TextStyle(fontSize: 13, height: 1.4),
      ),
    );
  }
}
