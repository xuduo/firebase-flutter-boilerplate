import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:model/providers/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:ui/widgets/loader.dart';

class WeatherScaffold extends StatelessWidget {
  const WeatherScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Weather App'),
          ),
          body: WeatherScreen(),
        ));
  }
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        return load(provider.weatherData, () {
          var data = provider.weatherData.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: data.temperatures.length.toDouble(),
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        data.temperatures.length,
                        (index) =>
                            FlSpot(index.toDouble(), data.temperatures[index]),
                      ),
                      isCurved: true,
                      colors: [Colors.blue],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: List.generate(
                        data.humidity.length,
                        (index) => FlSpot(
                            index.toDouble(), data.humidity[index].toDouble()),
                      ),
                      isCurved: true,
                      colors: [Colors.green],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
        // return Center(child: LinearProgressIndicator());
      },
    );
  }
}
