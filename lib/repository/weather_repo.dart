import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/models/location.dart';
import 'package:weather_forcast/models/weather_forecast.dart';
import 'package:weather_forcast/service/url_enpoints.dart';

class WeatherRepository {
  final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

  Future<Location> fetchCoordinatesByLocationName(String cityName) async {
    final response = await _getJson(
      "${UrlEndPoints.geo}?q=$cityName&limit=1&appid=$apiKey",
    );
    return LocationList.fromJson(response).list.first;
  }

  Future<CurrentWeather?> fetchCurrentWeatherData(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _getJson(
        "${UrlEndPoints.currentWeather}?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
      );
      return CurrentWeather.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<WeatherForecast?> fetchWeatherForecast(double lat, double lon) async {
    try {
      final response = await _getJson(
        "${UrlEndPoints.forecast}?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
      );
      return WeatherForecast.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> _getJson(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      debugConsolePrint(response, url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          "Failed request for $url. Status: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  debugConsolePrint(Response response, String url) {
    debugPrint("===== API CALL =====");
    debugPrint("url===============>>>> $url");
    debugPrint("statusCode=========>>>> ${response.statusCode}");
    debugPrint('Response Body: ${response.body}');
  }
}
