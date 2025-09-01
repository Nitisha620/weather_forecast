part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherData extends WeatherEvent {
  final String? cityName;
  const FetchWeatherData({this.cityName});

  @override
  List<Object?> get props => [cityName];
}

class ToggleMapLayer extends WeatherEvent {
  final String layer;
  const ToggleMapLayer(this.layer);

  @override
  List<Object?> get props => [layer];
}

class SelectMarker extends WeatherEvent {}

class DeselectMarker extends WeatherEvent {}
