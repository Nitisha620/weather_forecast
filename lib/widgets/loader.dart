import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_forcast/styles/app_theme.dart';

class ShimmerLoader extends StatelessWidget {
  final int? itemCount;
  final double? cardHeight;
  final EdgeInsets? cardPadding;

  const ShimmerLoader({
    this.itemCount,
    this.cardHeight,
    this.cardPadding,
    super.key,
  });

  Widget _shimmerBox({
    required double height,
    required double width,
    EdgeInsets margin = EdgeInsets.zero,
    double radius = 12,
  }) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppThemes.primaryColor.withAlpha(100),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding:
              cardPadding ??
              EdgeInsets.fromLTRB(12, size.height * 0.07, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(height: size.height * 0.06, width: size.width * 0.5),

              _shimmerBox(
                height: size.height * 0.06,
                width: size.width,
                margin: const EdgeInsets.symmetric(vertical: 12),
              ),

              _shimmerBox(height: size.height * 0.12, width: size.width * 0.45),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12.0,
                  runSpacing: 10,
                  children: List.generate(
                    6,
                    (_) => _shimmerBox(
                      height: size.height * 0.12,
                      width: size.width * 0.28,
                    ),
                  ),
                ),
              ),

              _shimmerBox(
                height: size.height * 0.35,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                radius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
