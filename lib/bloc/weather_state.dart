part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final bool isLoading;
  final CurrentWeather? currentWeather;
  final List<Map<String, dynamic>> weatherForecast;
  final Set<TileOverlay> overlays;
  final bool markerSelected;
  final String? errorMessage;

  const WeatherState({
    this.isLoading = false,
    this.currentWeather,
    this.weatherForecast = const [],
    this.overlays = const {},
    this.markerSelected = false,
    this.errorMessage,
  });

  WeatherState copyWith({
    bool? isLoading,
    CurrentWeather? currentWeather,
    List<Map<String, dynamic>>? weatherForecast,
    Set<TileOverlay>? overlays,
    bool? markerSelected,
    String? errorMessage,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      currentWeather: currentWeather ?? this.currentWeather,
      weatherForecast: weatherForecast ?? this.weatherForecast,
      overlays: overlays ?? this.overlays,
      markerSelected: markerSelected ?? this.markerSelected,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    currentWeather,
    weatherForecast,
    overlays,
    markerSelected,
    errorMessage,
  ];
}
