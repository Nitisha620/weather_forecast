import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/models/weather_forecast.dart';

class WeatherRepository {
  final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

  /* Params
  lat: Latitude
  lon: Longitude
  appid: unique API key 
  */
  Future<CurrentWeather> fetchCurrentWeatherData(String lat, String lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey',
        ),
      );
      debugConsolePrint(response);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return CurrentWeather.fromJson(responseBody);
      } else {
        debugPrint(
          "No Response while fetching current weather data in fetchCurrentWeatherData",
        );
        throw Exception(
          'Failed to fetch current weather data in fetchCurrentWeatherData',
        );
      }
    } catch (e) {
      throw Exception(
        'Failed to fetch current weather data in fetchCurrentWeatherData: $e',
      );
    }
  }

  Future<WeatherForecast> fetchWeatherForecast(String lat, String lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
        ),
      );
      debugConsolePrint(response);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return WeatherForecast.fromJson(responseBody);
      } else {
        debugPrint(
          "No Response while fetching weather forecast in fetchWeatherForecast",
        );
        throw Exception(
          'Failed to fetch weather forecast in fetchWeatherForecast',
        );
      }
    } catch (e) {
      throw Exception(
        'Failed to fetch weather forecast in fetchWeatherForecast: $e',
      );
    }
  }
}

debugConsolePrint(Response response, {String? payload}) {
  if (payload != null) debugPrint("apiPayload=========>>>> $payload");
  debugPrint("statusCode=========>>>> ${response.statusCode}");
  debugPrint('Response Body: ${response.body}');
}
