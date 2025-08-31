import 'package:flutter/material.dart';

class WeatherIconStyle {
  final IconData icon;
  final Color color;

  WeatherIconStyle(this.icon, this.color);
}

WeatherIconStyle getWeatherIconStyle(String code) {
  switch (code) {
    case "01d": // Clear day
      return WeatherIconStyle(Icons.wb_sunny, Colors.orange);

    case "01n": // Clear night
      return WeatherIconStyle(Icons.nights_stay, Colors.indigo);

    case "02d": // Few clouds day
    case "02n": // Few clouds night
      return WeatherIconStyle(Icons.cloud, Colors.blueGrey);

    case "03d":
    case "03n":
    case "04d":
    case "04n":
      return WeatherIconStyle(Icons.cloud_queue, Colors.white);

    case "09d":
    case "09n":
      return WeatherIconStyle(Icons.grain, Colors.lightBlue);

    case "10d":
    case "10n":
      return WeatherIconStyle(Icons.beach_access, Colors.brown);

    case "11d":
    case "11n":
      return WeatherIconStyle(Icons.flash_on, Colors.deepPurple);

    case "13d":
    case "13n":
      return WeatherIconStyle(Icons.ac_unit, Colors.cyan);

    case "50d":
    case "50n":
      return WeatherIconStyle(Icons.blur_on, Colors.teal);

    default:
      return WeatherIconStyle(Icons.help_outline, Colors.black54);
  }
}
