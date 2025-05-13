import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/pupularLocation/popular_locations_cubit.dart';
import 'package:weather_app/ui/widgets/currentWetherCard.dart';
import 'package:weather_app/ui/screens/infoScreen.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/currentWether.dart';
import 'package:weather_app/models/condition.dart';
import 'package:weather_app/models/air.dart';

class LocationCard extends StatelessWidget {
  final LocationWeather weather;

  const LocationCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Create a WeatherResponse object from the location weather data
        final weatherResponse = WeatherResponse(
          location: Location(
            name: weather.city,
            country: weather.country,
            region: '',
            lat: 0.0,
            lon: 0.0,
            tzId: 'UTC',
            localtime: DateTime.now().toIso8601String(),
          ),
          current: Current(
            lastUpdatedEpoch: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            lastUpdated: DateTime.now().toIso8601String(),
            tempC: weather.temp,
            tempF: (weather.temp * 9 / 5) + 32,
            isDay: 1,
            condition: Condition(text: weather.condition, icon: '', code: 0),
            windMph: 0,
            windKph: 0,
            windDegree: 0,
            windDir: '',
            pressureMb: 0,
            pressureIn: 0,
            precipMm: 0,
            precipIn: 0,
            humidity: 0,
            cloud: 0,
            feelslikeC: weather.temp,
            feelslikeF: (weather.temp * 9 / 5) + 32,
            windchillC: 0,
            windchillF: 0,
            heatindexC: 0,
            heatindexF: 0,
            dewpointC: 0,
            dewpointF: 0,
            visKm: 0,
            visMiles: 0,
            uv: 0,
            gustMph: 0,
            gustKph: 0,
            airQuality: AirQuality(
              co: 0,
              no2: 0,
              o3: 0,
              so2: 0,
              pm25: 0,
              pm10: 0,
              usEpaIndex: 1,
              gbDefraIndex: 1,
            ),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherInfoPage(weatherData: weatherResponse),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: _getGradient(weather.temp),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "${weather.temp.round()}°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "C",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    weather.city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    weather.country,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  _getWeatherIcon(weather.condition),
                  color: _getWeatherColor(weather.condition),
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    final lc = condition.toLowerCase();
    if (lc.contains('rain')) return Icons.umbrella;
    if (lc.contains('cloud')) return Icons.cloud;
    if (lc.contains('sun') || lc.contains('clear')) return Icons.wb_sunny;
    if (lc.contains('storm') || lc.contains('thunder'))
      return Icons.electric_bolt;
    if (lc.contains('snow')) return Icons.ac_unit;
    return Icons.thermostat;
  }

  Color _getWeatherColor(String condition) {
    final lc = condition.toLowerCase();
    if (lc.contains('rain') || lc.contains('storm'))
      return const Color(0xFF4287f5);
    if (lc.contains('cloud')) return const Color(0xFFa6b1c0);
    if (lc.contains('sun') || lc.contains('clear'))
      return const Color(0xFFFFC107);
    if (lc.contains('snow')) return const Color(0xFFd1e6ff);
    if (lc.contains('fog') || lc.contains('mist'))
      return const Color(0xFFc9c9c9);
    return const Color(0xFF8bc9ff);
  }

  LinearGradient _getGradient(double temp) {
    if (temp > 30) {
      return const LinearGradient(
        colors: [Color(0xFF2A303D), Color(0xFF453232)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temp > 20) {
      return const LinearGradient(
        colors: [Color(0xFF2A303D), Color(0xFF353D46)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temp < 5) {
      return const LinearGradient(
        colors: [Color(0xFF2A303D), Color(0xFF2A3645)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return const LinearGradient(
      colors: [Color(0xFF2A303D), Color(0xFF2A303D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
