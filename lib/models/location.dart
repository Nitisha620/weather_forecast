class LocationList {
  final List<Location> list;

  LocationList(this.list);

  factory LocationList.fromJson(List<dynamic> json) =>
      LocationList(json.map((e) => Location.fromJson(e)).toList());
}

class Location {
  final String name;
  final Map<String, String>? localNames;
  final double lat;
  final double lon;
  final String? country;
  final String? state;

  Location({
    required this.name,
    this.localNames,
    required this.lat,
    required this.lon,
    this.country,
    this.state,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      localNames: json['local_names'] != null
          ? Map<String, String>.from(json['local_names'])
          : null,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'local_names': localNames,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }
}
