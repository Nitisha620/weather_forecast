part of 'weather_bloc.dart';

class WeatherEvent {}

class FetchCurrentLocation extends WeatherEvent {
  String? cityName;
  FetchCurrentLocation({this.cityName});
}

class FetchCurrentWeather extends WeatherEvent {
  Position? position;
  FetchCurrentWeather({this.position});
}

class ToggleMapLayer extends WeatherEvent {
  final String layer;
  ToggleMapLayer(this.layer);
}

class SelectMarker extends WeatherEvent {}

class DeselectMarker extends WeatherEvent {}
