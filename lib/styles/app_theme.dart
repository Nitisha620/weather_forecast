import 'package:flutter/material.dart';
import 'app_text_style.dart';

class AppThemes {
  static const Color primaryColor = Color(0xFF008d97);
  static const Color midToneBlend = Color(0xFF4cb3bb);
  static const Color secondaryColor = Color(0xFFdfe9ed);
  static const Color greyColor = Color(0xFF585858);
  static const Color lightGreyColor = Color(0xFFADACAC);
  static const Color blureGreyColor = Color.fromRGBO(248, 250, 252, 1);
  static const Color foregroundColor = Color(0xFFFDFEFD);
  static const Color shadowColor = Color(0x3F909090);

  static final ThemeData themedata = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      foregroundColor: foregroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      elevation: 6,
      iconTheme: IconThemeData(size: 25, color: primaryColor),
    ),
    scaffoldBackgroundColor: foregroundColor,
    textTheme: TextTheme(
      headlineLarge: AppTextStyle.headlineLarge,
      headlineSmall: AppTextStyle.headlineSmall,
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      labelMedium: AppTextStyle.labelMedium,
      displayMedium: AppTextStyle.displayMedium,
    ).apply(),
    cardTheme: const CardThemeData().copyWith(
      color: const Color(0xFFFEFFFE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: const Color(0x3F909090),
      elevation: 4,
    ),

    // Bottom App Bar Theme
    bottomAppBarTheme: const BottomAppBarTheme().copyWith(
      elevation: 0,
      color: foregroundColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      shape: const CircularNotchedRectangle(),
    ),
  );
}
