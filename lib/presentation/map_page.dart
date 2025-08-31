import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forcast/bloc/weather_bloc.dart';
import 'package:weather_forcast/models/current_weather.dart';
import 'package:weather_forcast/styles/app_text_style.dart';
import 'package:weather_forcast/styles/app_theme.dart';
import 'package:weather_forcast/widgets/flutter_toast.dart';

class WeatherMap extends StatefulWidget {
  final CurrentWeather currentWeather;
  const WeatherMap({required this.currentWeather, super.key});

  @override
  State<WeatherMap> createState() => _WeatherMapState();
}

class _WeatherMapState extends State<WeatherMap> {
  final globalKey = GlobalKey<ScaffoldState>();
  WeatherBloc get weatherBloc => context.read<WeatherBloc>();
  Map<int, String> bottombarOptions = {0: "precipitation_new", 1: "temp_new"};
  int currentIndex = 0;
  late double lat;
  late double lon;
  late CurrentWeather currentWeather;

  @override
  void initState() {
    super.initState();

    weatherBloc.add(ToggleMapLayer(bottombarOptions[0]!));
    lat = widget.currentWeather.coord.lat;
    lon = widget.currentWeather.coord.lon;
    currentWeather = widget.currentWeather;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) async {
        if (state is Loading) {
          showToast("Please wait, Loading...");
        }
        if (state is Error) {
          showToast("Some error occurred, please try again later");
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: globalKey,
          body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, lon),
                      zoom: 6,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("current_location"),
                        position: LatLng(lat, lon),
                        onTap: () {
                          weatherBloc.add(SelectMarker());
                        },
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure,
                        ),
                      ),
                    },
                    tileOverlays: state is WeatherMapState
                        ? state.overlays
                        : <TileOverlay>{},
                    onTap: (_) {
                      weatherBloc.add(DeselectMarker());
                    },
                  ),
                  Positioned(
                    top: size.height * 0.05,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(255, 255, 255, 1),
                              const Color.fromRGBO(255, 255, 255, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(59, 59, 59, 0.247),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 12,
                              color: Color.fromRGBO(60, 60, 60, 0.251),
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  state is MarkerSelected
                      ? Positioned(
                          bottom: 10,
                          child: Container(
                            height: size.height * 0.1,
                            margin: EdgeInsets.all(10),
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                fieldWithLabel(
                                  size,
                                  "Current Temperature",
                                  "${currentWeather.main.temp.toString()} \u2103",
                                ),
                                SizedBox(height: 10),
                                fieldWithLabel(
                                  size,
                                  "Humidity Level",
                                  "${currentWeather.main.humidity.toString()} %",
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedLabelStyle: AppTextStyle.font12,
            unselectedLabelStyle: AppTextStyle.font11,
            onTap: (index) {
              currentIndex = index;
              weatherBloc.add(ToggleMapLayer(bottombarOptions[index]!));
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.opacity),
                label: 'Precipitation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wb_sunny),
                label: 'Temperature',
              ),
            ],
          ),
        );
      },
    );
  }

  showLocationInfo(Size size) {
    return Positioned(
      bottom: 10,
      child: Container(
        color: Colors.amber,
        height: size.height * 0.15,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fieldWithLabel(
              size,
              "Current Temperature",
              "${currentWeather.main.temp.toString()} \u2103",
            ),
            fieldWithLabel(
              size,
              "Humidity Level",
              "${currentWeather.main.humidity.toString()} %",
            ),
          ],
        ),
      ),
    );
  }
}

fieldWithLabel(Size size, String key, String value) {
  return Row(
    children: [
      SizedBox(
        width: size.width * 0.5,
        child: Text(
          key,
          style: GoogleFonts.poppins(
            color: const Color(0xFF45474B),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 45),
        child: const Text(":"),
      ),
      Text(
        value.trim(),
        style: AppTextStyle.font15Grey.copyWith(
          color: AppThemes.primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
