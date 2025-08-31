import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/repository/weather_repo.dart';
import 'package:weather_forcast/service/location_service.dart';
import 'package:weather_forcast/service/url_tile_provider.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository = WeatherRepository();
  final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

  WeatherBloc() : super(Initial()) {
    on<FetchCurrentLocation>(fetchCurrentLocation);
    on<ToggleMapLayer>((event, emit) {
      emit(Loading());
      try {
        final overlay = TileOverlay(
          tileOverlayId: TileOverlayId(event.layer),
          tileProvider: UrlTileProvider(
            256,
            256,
            (x, y, zoom) =>
                "https://tile.openweathermap.org/map/${event.layer}/$zoom/$x/$y.png?appid=$apiKey",
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

  Future<void> fetchCurrentLocation(
    FetchCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(Loading());
      double? lat;
      double? lon;
      if (event.cityName?.isEmpty ?? true) {
        final position = await LocationService.getCurrentLocation();
        if (position != null) {
          lat = position.latitude;
          lon = position.longitude;
        }
      } else {
        final searchedLocation = await weatherRepository
            .fetchCoordinatesByLocationName(event.cityName!);
        lat = searchedLocation.lat;
        lon = searchedLocation.lon;
      }

      if (lat != null && lon != null) {
        final futures = [
          fetchCurrentWeather(lat, lon),
          fetchWeatherForecast(lat, lon),
        ];

        final results = await Future.wait(futures);

        final currentWeather = results[0] != null
            ? results[0] as CurrentWeather
            : CurrentWeather.empty();
        final weatherForecast = results[1] != null
            ? results[1] as List<Map<String, dynamic>>
            : [] as List<Map<String, dynamic>>;
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

  Future<CurrentWeather?> fetchCurrentWeather(double lat, double lon) async {
    try {
      return await weatherRepository.fetchCurrentWeatherData(lat, lon);
    } catch (e) {
      debugPrint("Error while fetching current weather $e");
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchWeatherForecast(
    double lat,
    double lon,
  ) async {
    try {
      final forecast = await weatherRepository.fetchWeatherForecast(lat, lon);
      return processForecast(forecast.list);
    } catch (e) {
      debugPrint("Error while fetching weather forecast $e");
    }
    return [];
  }

  List<Map<String, dynamic>> processForecast(
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
