import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/models/weather_forecast.dart';
import 'package:weather_forcast/repository/weather_repo.dart';
import 'package:weather_forcast/service/location_service.dart';
import 'package:weather_forcast/service/url_enpoints.dart';
import 'package:weather_forcast/service/url_tile_provider.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository = WeatherRepository();
  final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

  WeatherBloc() : super(Initial()) {
    on<FetchWeatherData>(fetchWeatherData);
    on<ToggleMapLayer>((event, emit) {
      emit(Loading());
      try {
        final overlay = TileOverlay(
          tileOverlayId: TileOverlayId(event.layer),
          tileProvider: UrlTileProvider(
            256,
            256,
            (x, y, zoom) =>
                "${UrlEndPoints.weatherMap}${event.layer}/$zoom/$x/$y.png?appid=$apiKey",
          ),
        );

        emit(WeatherMapState(overlays: {overlay}));
      } catch (e) {
        emit(Error(message: "Error while fetching map layer data"));
      }
    });
    on<SelectMarker>((event, emit) {
      emit(MarkerSelected());
    });
    on<DeselectMarker>((event, emit) {
      emit(MarkerDeselected());
    });
  }

  Future<void> fetchWeatherData(
    FetchWeatherData event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(Loading());

      final coordinates = await _getCoordinates(event.cityName);

      if (coordinates == null) {
        emit(Error(message: "Unable to fetch location"));
        return;
      }

      final (lat, lon) = coordinates;

      final results = await Future.wait([
        weatherRepository.fetchCurrentWeatherData(lat, lon),
        weatherRepository.fetchWeatherForecast(lat, lon),
      ]);

      final currentWeather = results[0] as CurrentWeather;
      final weatherForecast = _processForecast(
        (results[1] as WeatherForecast).list,
      );
      emit(
        Loaded(
          currentWeather: currentWeather,
          weatherForecast: weatherForecast,
        ),
      );
    } catch (e) {
      emit(
        Error(
          message:
              "Error while fetching weather data, please refresh or try again later",
        ),
      );
    }
  }

  Future<(double, double)?> _getCoordinates(String? cityName) async {
    try {
      if (cityName?.isEmpty ?? true) {
        final pos = await LocationService.getCurrentLocation();
        if (pos != null) return (pos.latitude, pos.longitude);
      } else {
        final loc = await weatherRepository.fetchCoordinatesByLocationName(
          cityName!,
        );
        return (loc.lat, loc.lon);
      }
    } catch (e) {
      debugPrint("Error resolving coordinates: $e");
    }
    return null;
  }

  List<Map<String, dynamic>> _processForecast(
    List<CurrentWeather> forecastList,
  ) {
    Map<String, List<CurrentWeather>> grouped = {};

    for (CurrentWeather item in forecastList) {
      String date = item.dtTxt.split(" ")[0];
      grouped.putIfAbsent(date, () => []).add(item);
    }

    List<Map<String, dynamic>> result = [];

    grouped.forEach((date, items) {
      double minTemp = items
          .map((e) => e.main.tempMin as num)
          .reduce((a, b) => a < b ? a : b)
          .toDouble();
      double maxTemp = items
          .map((e) => e.main.tempMax as num)
          .reduce((a, b) => a > b ? a : b)
          .toDouble();

      CurrentWeather midday = items.firstWhere(
        (e) => e.dtTxt.contains("12:00:00"),
        orElse: () => items[0],
      );
      String icon = midday.weather.first.icon;

      result.add({"date": date, "min": minTemp, "max": maxTemp, "icon": icon});
    });
    return result.take(5).toList();
  }
}
