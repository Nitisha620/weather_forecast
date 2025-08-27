import 'package:flutter/material.dart';
import 'package:weather_forcast/styles/app_text_style.dart';
import 'package:weather_forcast/styles/app_theme.dart';

import '../widgets/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(12, size.height * 0.08, 12, 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppThemes.primaryColor,
                AppThemes.midToneBlend,
                AppThemes.secondaryColor,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppThemes.secondaryColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Gwalior",
                    style: AppTextStyle.font20Black.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppThemes.secondaryColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Search(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 30),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "21\u2103",
                          style: AppTextStyle.font40Secondary.copyWith(
                            fontSize: 70,
                            color: AppThemes.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Mostly cloudy 27\u2103 / 33\u2103 \nAir Quality: 51 - Satisfactory ",
                          style: AppTextStyle.font18.copyWith(
                            fontSize: 16,
                            color: AppThemes.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12.0,
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < 6; i++)
                            Column(
                              children: [
                                Container(
                                  width: size.width * 0.28,
                                  height: size.height * 0.12,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppThemes.primaryColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.energy_savings_leaf,
                                        color: AppThemes.secondaryColor,
                                      ),
                                      Text(
                                        "Feels like",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.font14.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: AppThemes.secondaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "37\u2103",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.font18Grey.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppThemes.secondaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal:5),
                width: size.width,
                height: size.height * 0.6,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppThemes.primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.energy_savings_leaf,
                      color: AppThemes.secondaryColor,
                    ),
                    Text(
                      "Feels like",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font14.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppThemes.secondaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "37\u2103",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font18Grey.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppThemes.secondaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
