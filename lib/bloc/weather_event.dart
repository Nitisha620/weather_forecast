part of 'weather_bloc.dart';

class WeatherEvent {}

class FetchCurrentLocation extends WeatherEvent{}

class FetchCurrentWeather extends WeatherEvent {
  Position? position;
  FetchCurrentWeather({this.position});
}
