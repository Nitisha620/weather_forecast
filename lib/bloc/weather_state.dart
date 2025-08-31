part of 'weather_bloc.dart';

class WeatherState {}

class Initial extends WeatherState {}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final CurrentWeather currentWeather;
  final List<Map<String, dynamic>> weatherForecast;
  Loaded({required this.currentWeather, required this.weatherForecast});
}

class Error extends WeatherState {
  String message;
  Error({required this.message});
}

class WeatherMapState extends WeatherState {
  final Set<TileOverlay> overlays;

  WeatherMapState({this.overlays = const {}});

  WeatherMapState copyWith({Set<TileOverlay>? overlays}) {
    return WeatherMapState(overlays: overlays ?? this.overlays);
  }
}

class MarkerSelected extends WeatherState {}

class MarkerDeselected extends WeatherState {}
