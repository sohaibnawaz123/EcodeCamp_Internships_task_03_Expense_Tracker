import 'package:expencetrackerapp/utils/constants/textStyle.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../model/barModel.dart';
import '../../utils/constants/colors.dart';

class MyBarGraph extends StatelessWidget {
  final List<IndividualBar> barData;
  final double totalBalance;
  final List<String> categoryNames; // List of category names

  const MyBarGraph({
    super.key,
    required this.barData,
    required this.totalBalance,
    required this.categoryNames, // Receive the category names
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      maxY: totalBalance,
      minY: 0,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              // Display category name for each x-axis label
              final index = value.toInt();
              if (index < categoryNames.length) {
                return Text(
                  categoryNames[index].substring(0,4).toUpperCase(), // Set category name
                  style: appHeading(14, AppColor.black,weight: FontWeight.w900)
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      barGroups: barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                    toY: data.y,
                    gradient: const LinearGradient(colors: [
                      AppColor.secondaryColor,
                      AppColor.primaryColor,
                      AppColor.tertiary
                    ], transform: GradientRotation(0.785)),
                    width: 20,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.grey[300],
                      toY: totalBalance,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)))
              ]))
          .toList(),
    ));
  }
}
