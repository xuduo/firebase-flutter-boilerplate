import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:model/db/objectbox.dart';
import '../data/data.dart';
import '../data/weather.dart';
import '../objectbox.g.dart';
import '../util/logger.dart';

class WeatherProvider with ChangeNotifier {

  final Logger _logger = Logger(WeatherProvider);

  Data<Weather> weatherData = Data();
  bool isLoading = false;
  String? errorMessage;
  Box<Weather> box = store.box<Weather>();

  WeatherProvider() {
    fetchWeatherDb();
    fetchWeather();
  }

  fetchWeatherDb() async {
    weatherData.data = await box.getAsync(1);
    if (weatherData.data != null) {
      _logger.debug('fetchWeather db result: ${weatherData.data}');
      notifyListeners();
    }
  }

  Future<void> fetchWeather() async {
    isLoading = true;
    final url = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,windspeed_10m&hourly=temperature_2m,relativehumidity_2m,windspeed_10m";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        weatherData.data = Weather.fromJson(json.decode(response.body));
        if(await box.getAsync(1) != null){
          weatherData.data?.id = 1;
        }
        box.putAsync(weatherData.data!);
      } else {
        weatherData.errorMessage = 'Failed to load data';
      }
    } catch (error) {
      weatherData.errorMessage = error.toString();
    }
    _logger.debug('fetchWeather result: $weatherData $errorMessage');
    isLoading = false;
    notifyListeners();
  }
}
