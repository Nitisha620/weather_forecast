import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_forcast/styles/app_text_style.dart';

class TempChart extends StatelessWidget {
  final List<String> days = ['Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<double> minTemps = [27, 26, 29, 28, 25];
  final List<double> maxTemps = [33, 32, 35, 34, 31];
  final List<String> weatherIcons = ["☀️", "🌧️", "☁️", "⛈️", "❄️"];

  TempChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();

                // only show labels if it's a valid index
                if (value % 1 == 0 && index >= 0 && index < days.length) {
                  return Column(
                    children: [
                      Expanded(
                        child: Text(
                          days[index],
                          style: AppTextStyle.font12Grey,
                        ),
                      ),
                      Expanded(
                        child: Text(weatherIcons[index % weatherIcons.length]),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 2,
              maxIncluded: false,
              minIncluded: false,
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}°C', style: AppTextStyle.font12);
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        // ✅ Fix range to match 5 days
        minX: 0,
        maxX: (days.length - 1).toDouble(),

        // ✅ dynamic range for temps
        minY: (minTemps.reduce((a, b) => a < b ? a : b)) - 2,
        maxY: (maxTemps.reduce((a, b) => a > b ? a : b)) + 2,
        lineBarsData: [
          // Max temp line (Red)
          LineChartBarData(
            spots: List.generate(
              maxTemps.length,
              (i) => FlSpot(i.toDouble(), maxTemps[i]),
            ),
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
          ),
          // Min temp line (Blue)
          LineChartBarData(
            spots: List.generate(
              minTemps.length,
              (i) => FlSpot(i.toDouble(), minTemps[i]),
            ),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
