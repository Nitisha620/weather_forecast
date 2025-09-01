import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

class AppTextStyle {
  static TextStyle font11 = GoogleFonts.poppins(
    color: AppThemes.secondaryColor,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  static TextStyle font12 = GoogleFonts.poppins(
    color: AppThemes.secondaryColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font14 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppThemes.secondaryColor,
  );

  static TextStyle font15 = GoogleFonts.poppins(
    color: AppThemes.primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static TextStyle font16 = GoogleFonts.poppins(
    fontSize: 16,
    color: AppThemes.secondaryColor,
  );

  static TextStyle font25 = GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: AppThemes.secondaryColor,
  );

  static TextStyle largeText = GoogleFonts.manrope(
    fontSize: 70,
    color: AppThemes.secondaryColor,
    fontWeight: FontWeight.w500,
  );
}
