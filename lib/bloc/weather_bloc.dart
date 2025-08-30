import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/models/weather_forecast.dart';
import 'package:weather_forcast/repository/weather_repo.dart';
import 'package:weather_forcast/service/location_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository = WeatherRepository();
  WeatherBloc() : super(Initial()) {
    on<FetchCurrentLocation>(fetchCurrentLocation);
  }

  Future<void> fetchCurrentLocation(
    FetchCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(Loading());
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        final futures = [
          fetchCurrentWeather(position),
          fetchWeatherForecast(position),
        ];

        final results = await Future.wait(futures);

        final currentWeather = results[0] as CurrentWeather;
        final weatherForecast = results[1] as WeatherForecast;
        emit(
          Loaded(
            currentWeather: currentWeather,
            weatherForecast: weatherForecast,
          ),
        );
      } else {
        emit(Error(message: "Error while fetching current location"));
      }
    } catch (e) {
      debugPrint("Error while fetching current location $e");
      emit(Error(message: e.toString()));
    }
  }

  Future<CurrentWeather> fetchCurrentWeather(Position position) async {
    try {
      return await weatherRepository.fetchCurrentWeatherData(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      debugPrint("Error while fetching current weather $e");
      rethrow;
    }
  }

  Future<WeatherForecast> fetchWeatherForecast(Position position) async {
    try {
      return await weatherRepository.fetchWeatherForecast(
        position.longitude,
        position.longitude,
      );
    } catch (e) {
      debugPrint("Error while fetching weather forecast $e");
      rethrow;
    }
  }
}
