import 'package:flutter/material.dart';
import 'package:weather_forcast/styles/app_text_style.dart';
import 'package:weather_forcast/styles/app_theme.dart';

class Search extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const Search({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        controller: controller,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyle.font14Manrope,
        decoration: InputDecoration(
          filled: false,
          hintText: hintText ?? "Search",
          hintStyle: AppTextStyle.font13,
          prefixIcon: const Icon(Icons.search, color: AppThemes.secondaryColor, size: 25),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: AppThemes.secondaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelStyle: AppTextStyle.font11,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: AppThemes.secondaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
