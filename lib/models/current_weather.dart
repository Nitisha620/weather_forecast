class CurrentWeather {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final num visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  final double pop;
  final String dtTxt;
  final Rain rain;

  const CurrentWeather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.pop,
    required this.dtTxt,
    required this.rain,
  });

  factory CurrentWeather.empty() => CurrentWeather(
        coord: Coord.empty(),
        weather: const [],
        base: '',
        main: Main.empty(),
        visibility: 0,
        wind: Wind.empty(),
        clouds: Clouds.empty(),
        dt: 0,
        sys: Sys.empty(),
        timezone: 0,
        id: 0,
        name: '',
        cod: 0,
        pop: 0.0,
        dtTxt: '',
        rain: Rain.empty(),
      );

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        coord: json['coord'] != null ? Coord.fromJson(json['coord']) : Coord.empty(),
        weather: (json['weather'] as List<dynamic>?)
                ?.map((v) => Weather.fromJson(v))
                .toList() ??
            [],
        base: json['base'] ?? '',
        main: json['main'] != null ? Main.fromJson(json['main']) : Main.empty(),
        visibility: json['visibility'] ?? 0,
        wind: json['wind'] != null ? Wind.fromJson(json['wind']) : Wind.empty(),
        clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : Clouds.empty(),
        dt: json['dt'] ?? 0,
        sys: json['sys'] != null ? Sys.fromJson(json['sys']) : Sys.empty(),
        timezone: json['timezone'] ?? 0,
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        cod: json['cod'] ?? 0,
        pop: (json['pop'] ?? 0).toDouble(),
        dtTxt: json['dt_txt'] ?? '',
        rain: json['rain'] != null ? Rain.fromJson(json['rain']) : Rain.empty(),
      );

  Map<String, dynamic> toJson() => {
        'coord': coord.toJson(),
        'weather': weather.map((v) => v.toJson()).toList(),
        'base': base,
        'main': main.toJson(),
        'visibility': visibility,
        'wind': wind.toJson(),
        'clouds': clouds.toJson(),
        'dt': dt,
        'sys': sys.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
        'pop': pop,
        'dt_txt': dtTxt,
        'rain': rain.toJson(),
      };
}

class Coord {
  final double lat;
  final double lon;

  const Coord({required this.lat, required this.lon});

  factory Coord.empty() => const Coord(lat: 0.0, lon: 0.0);

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: (json['lat'] ?? 0).toDouble(),
        lon: (json['lon'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {'lat': lat, 'lon': lon};
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.empty() => const Weather(id: 0, main: '', description: '', icon: '');

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] ?? 0,
        main: json['main'] ?? '',
        description: json['description'] ?? '',
        icon: json['icon'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
  final double tempKf;

  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
    required this.tempKf,
  });

  factory Main.empty() => const Main(
        temp: 0,
        feelsLike: 0,
        tempMin: 0,
        tempMax: 0,
        pressure: 0,
        humidity: 0,
        seaLevel: 0,
        grndLevel: 0,
        tempKf: 0,
      );

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: (json['temp'] ?? 0).toDouble(),
        feelsLike: (json['feels_like'] ?? 0).toDouble(),
        tempMin: (json['temp_min'] ?? 0).toDouble(),
        tempMax: (json['temp_max'] ?? 0).toDouble(),
        pressure: json['pressure'] ?? 0,
        humidity: json['humidity'] ?? 0,
        seaLevel: json['sea_level'] ?? 0,
        grndLevel: json['grnd_level'] ?? 0,
        tempKf: (json['temp_kf'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'temp_kf': tempKf,
      };
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  const Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.empty() => const Wind(speed: 0, deg: 0, gust: 0);

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json['speed'] ?? 0).toDouble(),
        deg: json['deg'] ?? 0,
        gust: (json['gust'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}

class Clouds {
  final int all;

  const Clouds({required this.all});

  factory Clouds.empty() => const Clouds(all: 0);

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(all: json['all'] ?? 0);

  Map<String, dynamic> toJson() => {'all': all};
}

class Sys {
  final String country;
  final int sunrise;
  final int sunset;
  final String pod;

  const Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.pod,
  });

  factory Sys.empty() => const Sys(country: '', sunrise: 0, sunset: 0, pod: '');

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json['country'] ?? '',
        sunrise: json['sunrise'] ?? 0,
        sunset: json['sunset'] ?? 0,
        pod: json['pod'] ?? '',
      );

  Map<String, dynamic> toJson() =>
      {'country': country, 'sunrise': sunrise, 'sunset': sunset, 'pod': pod};
}

class Rain {
  final double d3h;

  const Rain({required this.d3h});

  factory Rain.empty() => const Rain(d3h: 0);

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(d3h: (json['3h'] ?? 0).toDouble());

  Map<String, dynamic> toJson() => {'3h': d3h};
}
