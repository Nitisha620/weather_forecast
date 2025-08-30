import 'package:weather_forcast/models/current_weather.dart';

class WeatherForecast {
  final String cod;
  final int message;
  final int cnt;
  final List<CurrentWeather> list;
  final City city;

  WeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  /// Factory constructor for defaults
  factory WeatherForecast.empty() {
    return WeatherForecast(
      cod: "--",
      message: 0,
      cnt: 0,
      list: [],
      city: City.empty(),
    );
  }

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      cod: json['cod'] ?? "--",
      message: json['message'] ?? 0,
      cnt: json['cnt'] ?? 0,
      list: (json['list'] as List<dynamic>?)
              ?.map((v) => CurrentWeather.fromJson(v))
              .toList() ??
          [],
      city: json['city'] != null ? City.fromJson(json['city']) : City.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((v) => v.toJson()).toList(),
      'city': city.toJson(),
    };
  }
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  /// Defaults
  factory City.empty() {
    return City(
      id: 0,
      name: "--",
      coord: Coord.empty(),
      country: "--",
      population: 0,
      timezone: 0,
      sunrise: 0,
      sunset: 0,
    );
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? "--",
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : Coord.empty(),
      country: json['country'] ?? "--",
      population: json['population'] ?? 0,
      timezone: json['timezone'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  /// Defaults
  factory Coord.empty() {
    return Coord(lat: 0.0, lon: 0.0);
  }

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}
