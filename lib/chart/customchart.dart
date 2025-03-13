import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40), // ✅ Left Y-axis only
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => _bottomTitle(value.toInt()),
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // ❌ Hide top labels
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // ❌ Hide right labels
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: Colors.black, width: 1),  // ✅ Left border only
            bottom: BorderSide(color: Colors.black, width: 1), // ✅ Bottom border only
          ),
        ),
        gridData: FlGridData(show: false), // ❌ Hide grid lines
        barGroups: [
          _barData(0, 30, Colors.blue),
          _barData(1, 45, Colors.green),
          _barData(2, 60, Colors.orange),
          _barData(3, 50, Colors.purple),
          _barData(4, 90, Colors.red),
          _barData(5, 40, Colors.yellow),
          _barData(6, 35, Colors.teal),
        ],
      ),
    );
  }

  /// 🟦 Custom Bar Data with Rounded Edges
  BarChartGroupData _barData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 14, // Custom width
          color: Colors.amber, // Custom color
          borderRadius: BorderRadius.circular(6), // ✅ Rounded bars
        ),
      ],
    );
  }

  /// 📅 X-Axis Labels
  Widget _bottomTitle(int value) {
    List<String> times = ["09:00", "12:10", "13:40", "16:00", "17:05", "18:10", "20:00"];
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Text(times[value], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
