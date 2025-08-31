import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcast/styles/app_text_style.dart';
import 'package:weather_forcast/utils/icon_util.dart';

class TempChart extends StatefulWidget {
  final List<Map<String, dynamic>> forecasetInfo;

  const TempChart({required this.forecasetInfo, super.key});

  @override
  State<TempChart> createState() => _TempChartState();
}

class _TempChartState extends State<TempChart> {
  List<Map<String, dynamic>> forecasetInfo = [];
  List<double> minTemps = [];
  List<double> maxTemps = [];

  @override
  void initState() {
    super.initState();
    forecasetInfo = widget.forecasetInfo;
    for (var i in forecasetInfo) {
      minTemps.add(i['min']);
      maxTemps.add(i['max']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) =>
                Colors.white.withAlpha(51), // background

            tooltipPadding: const EdgeInsets.all(10),
            tooltipMargin: 8,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final textStyle = AppTextStyle.font14Manrope;

                String label;
                if (touchedSpot.barIndex == 0) {
                  label = "Max: ${touchedSpot.y.toStringAsFixed(1)}°C";
                } else if (touchedSpot.barIndex == 1) {
                  label = "Min: ${touchedSpot.y.toStringAsFixed(1)}°C";
                } else {
                  label = "Value: ${touchedSpot.y.toStringAsFixed(1)}";
                }
                return LineTooltipItem(label, textStyle);
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (value % 1 == 0 &&
                    index >= 0 &&
                    index < widget.forecasetInfo.length) {
                  final style = getWeatherIconStyle(
                    widget.forecasetInfo[index]['icon'],
                  );
                  return Column(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat('EEE').format(
                            DateTime.parse(
                              widget.forecasetInfo[index]['date'].toString(),
                            ),
                          ),
                          style: AppTextStyle.font12Grey,
                        ),
                      ),
                      Icon(style.icon, color: style.color),
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
        minX: 0,
        maxX: (widget.forecasetInfo.length - 1).toDouble(),
        minY: (minTemps.reduce((a, b) => a < b ? a : b)) - 2,
        maxY: (maxTemps.reduce((a, b) => a > b ? a : b)) + 2,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              maxTemps.length,
              (i) => FlSpot(i.toDouble(), maxTemps[i]),
            ),
            isCurved: true,
            color: Colors.red,
            barWidth: 1.5,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
          ),
          LineChartBarData(
            spots: List.generate(
              minTemps.length,
              (i) => FlSpot(i.toDouble(), minTemps[i]),
            ),
            isCurved: true,
            color: Colors.blue,
            barWidth: 1.5,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
