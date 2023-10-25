import 'package:objectbox/objectbox.dart';

@Entity()
class Weather {
  int id;

  List<double> temperatures;
  List<String> times;
  List<int> humidity;

  Weather(
      {this.id = 0,
      required this.temperatures,
      required this.times,
      required this.humidity});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temperatures: List<double>.from(json['hourly']['temperature_2m']),
        times: List<String>.from(json['hourly']['time']),
        humidity: List<int>.from(json['hourly']['relativehumidity_2m']));
  }
}
