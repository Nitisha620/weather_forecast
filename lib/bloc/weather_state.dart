part of 'weather_bloc.dart';

class WeatherState {}

class Initial extends WeatherState {}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final CurrentWeather currentWeather;
  final WeatherForecast weatherForecast;
  Loaded({required this.currentWeather, required this.weatherForecast});
}

class Error extends WeatherState {
  String message;
  Error({required this.message});
}
