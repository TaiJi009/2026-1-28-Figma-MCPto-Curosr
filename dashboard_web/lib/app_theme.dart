import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens from Figma Nucleus UI (– Dark).
/// PRD: 设计规范（来自 Figma / Nucleus – Dark）
class AppColors {
  static const Color primary = Color(0xFF6B4EFF);       // rgb(107, 78, 255)
  static const Color backgroundDark = Color(0xFF090A0A); // rgb(9, 10, 10)
  static const Color surface = Color(0xFF0D0E0F);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF979C9E);  // rgb(151, 156, 158)
  static const Color divider = Color(0xFFDADADA);        // rgb(218, 218, 218)
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFFF5247);          // rgb(255, 82, 71)
}

class AppDims {
  static const double radiusButton = 48.0;
  static const double radiusCard = 12.0;
  static const double radiusInput = 8.0;
  static const double paddingPage = 24.0;
  static const double paddingCard = 16.0;
}

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.divider,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.interTextTheme(_textTheme()),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'Inter'),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDims.radiusCard)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDims.radiusButton)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDims.radiusInput)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDims.radiusInput),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDims.radiusInput),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.backgroundDark,
        selectedIconTheme: const IconThemeData(color: AppColors.primary),
        unselectedIconTheme: const IconThemeData(color: AppColors.textSecondary),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500, fontFamily: 'Inter');
          }
          return const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontFamily: 'Inter');
        }),
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(AppColors.surface),
        dataRowColor: WidgetStateProperty.all(Colors.transparent),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDims.radiusCard),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
    );
  }

  static TextTheme _textTheme() {
    const Color p = AppColors.textPrimary;
    const Color s = AppColors.textSecondary;
    return TextTheme(
      displayLarge: const TextStyle(fontSize: 32, height: 36 / 32, fontWeight: FontWeight.bold, color: p, fontFamily: 'Inter'),
      titleLarge: const TextStyle(fontSize: 24, height: 32 / 24, fontWeight: FontWeight.w600, color: p, fontFamily: 'Inter'),
      titleMedium: const TextStyle(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w600, color: p, fontFamily: 'Inter'),
      bodyLarge: const TextStyle(fontSize: 16, height: 24 / 16, color: p, fontFamily: 'Inter'),
      bodyMedium: const TextStyle(fontSize: 14, height: 20 / 14, color: p, fontFamily: 'Inter'),
      bodySmall: const TextStyle(fontSize: 12, height: 16 / 12, color: s, fontFamily: 'Inter'),
      labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: p, fontFamily: 'Inter'),
    );
  }
}
