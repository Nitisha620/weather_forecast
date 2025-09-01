import 'package:flutter/material.dart';

class AppThemes {
  static const Color primaryColor = Color(0xFF008d97);
  static const Color midToneBlend = Color(0xFF4cb3bb);
  static const Color secondaryColor = Color(0xFFdfe9ed);
  static const Color greyColor = Color(0xFF585858);
  static const Color foregroundColor = Color(0xFFFDFEFD);
  static final ThemeData themedata = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    scaffoldBackgroundColor: foregroundColor,
    bottomAppBarTheme: const BottomAppBarTheme().copyWith(
      elevation: 0,
      color: foregroundColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      shape: const CircularNotchedRectangle(),
    ),
  );
}
