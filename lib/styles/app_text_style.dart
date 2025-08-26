import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

class AppTextStyle {
  // App Theme Style
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 0,
    letterSpacing: 1.05,
  );

  static TextStyle headlineSmall = GoogleFonts.manrope(
    color: AppThemes.greyColor,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 0,
    letterSpacing: 0.59,
  );

  static TextStyle titleLarge = GoogleFonts.poppins(
    color: AppThemes.greyColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    color: AppThemes.lightGreyColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle labelMedium = GoogleFonts.poppins(
    color: AppThemes.greyColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    color: AppThemes.primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static TextStyle font11 = GoogleFonts.poppins(
    color: const Color(0xFF536471),
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font12 = GoogleFonts.poppins(
    color: const Color(0xFF536471),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font14 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font14Manrope = GoogleFonts.manrope();

  static TextStyle font14Primary = GoogleFonts.poppins(
    color: AppThemes.primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle font40Secondary = GoogleFonts.inter(
    fontSize: 40,
    color: AppThemes.secondaryColor,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font13Grey = GoogleFonts.poppins(
    color: AppThemes.greyColor,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle font14Grey = GoogleFonts.poppins(
    color: AppThemes.greyColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font15Grey = GoogleFonts.poppins(
    color: AppThemes.greyColor,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font18Grey = GoogleFonts.poppins(
    color: AppThemes.greyColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font15Black = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font18 = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static TextStyle font20Black = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
