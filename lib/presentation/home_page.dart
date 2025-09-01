import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:weather_forcast/bloc/weather_bloc.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/presentation/map_page.dart';
import 'package:weather_forcast/styles/app_text_style.dart';
import 'package:weather_forcast/styles/app_theme.dart';
import 'package:weather_forcast/widgets/flutter_toast.dart';
import 'package:weather_forcast/presentation/temp_chart.dart';
import 'package:weather_forcast/widgets/loader.dart';

import '../widgets/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String enteredCityName = "";
  WeatherBloc get weatherBloc => context.read<WeatherBloc>();

  @override
  void initState() {
    super.initState();
    weatherBloc.add(FetchWeatherData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.errorMessage?.isNotEmpty ?? false) {
          cancelToast();
          showToast(state.errorMessage!);
        }
      },
      child: Scaffold(
        body: Container(
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
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              final weatherInfo =
                  state.currentWeather ?? CurrentWeather.empty();
              final List<Map<String, dynamic>> forecasetInfo =
                  state.weatherForecast;

              return state.isLoading
                  ? SizedBox.expand(child: ShimmerLoader())
                  : weatherInfoWidget(weatherInfo, forecasetInfo);
            },
          ),
        ),
      ),
    );
  }

  weatherInfoWidget(
    CurrentWeather weatherInfo,
    List<Map<String, dynamic>> forecasetInfo,
  ) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        weatherBloc.add(FetchWeatherData(cityName: enteredCityName));
      },
      child: SizedBox.expand(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(12, size.height * 0.07, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppThemes.secondaryColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        enteredCityName.isEmpty
                            ? weatherInfo.name
                            : enteredCityName,
                        style: AppTextStyle.font25,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapPage(currentWeather: weatherInfo),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.map_outlined,
                        color: AppThemes.secondaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Search(
                  onSubmitted: (text) {
                    enteredCityName = text;
                    weatherBloc.add(FetchWeatherData(cityName: text));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 30),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${weatherInfo.main.temp}\u2103",
                          style: AppTextStyle.largeText.copyWith(
                            fontSize: 70,
                            color: AppThemes.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        weatherInfo.weather.isNotEmpty
                            ? Text(
                                "${weatherInfo.weather.first.description.toTitleCase} ${weatherInfo.main.tempMin}\u2103 /  ${weatherInfo.main.tempMax}\u2103",
                                style: AppTextStyle.font16,
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
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
                          weatherElementsInfo(
                            Icons.thermostat,
                            "Feels like",
                            "${weatherInfo.main.feelsLike} ",
                            unit: "\u2103",
                          ),
                          weatherElementsInfo(
                            Icons.water_drop,
                            "Humidity",
                            "${weatherInfo.main.humidity}",
                            unit: " %",
                          ),
                          weatherElementsInfo(
                            Icons.cloud,
                            "Cloud cover",
                            "${weatherInfo.clouds.all}",
                            unit: " %",
                          ),
                          weatherElementsInfo(
                            Icons.speed,
                            "Air Pressure",
                            "${weatherInfo.main.pressure}",
                            unit: " hPa",
                          ),
                          weatherElementsInfo(
                            Icons.air,
                            "Wind speed",
                            "${weatherInfo.wind.speed}",
                            unit: " m/s",
                          ),

                          weatherElementsInfo(
                            Icons.explore,
                            "Wind direction",
                            "${weatherInfo.wind.deg}",
                            unit:
                                " \u00B0${getWindDirection(weatherInfo.wind.deg)}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: size.width,
                height: size.height * 0.35,
                padding: EdgeInsets.fromLTRB(15, 10, 30, 10),
                decoration: BoxDecoration(
                  color: AppThemes.primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: forecasetInfo.isNotEmpty
                    ? TempChart(forecasetInfo: forecasetInfo)
                    : SizedBox.expand(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  weatherElementsInfo(
    IconData icon,
    String label,
    String value, {
    String? unit,
  }) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppThemes.secondaryColor),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyle.font14,
                overflow: TextOverflow.ellipsis,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: value, style: AppTextStyle.font14),
                    TextSpan(
                      text: unit ?? "",
                      style: AppTextStyle.font12.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppThemes.secondaryColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getWindDirection(int degree) {
    if (degree >= 337.5 || degree < 22.5) return "N";
    if (degree >= 22.5 && degree < 67.5) return "NE";
    if (degree >= 67.5 && degree < 112.5) return "E";
    if (degree >= 112.5 && degree < 157.5) return "SE";
    if (degree >= 157.5 && degree < 202.5) return "S";
    if (degree >= 202.5 && degree < 247.5) return "SW";
    if (degree >= 247.5 && degree < 292.5) return "W";
    if (degree >= 292.5 && degree < 337.5) return "NW";
    return "";
  }
}
