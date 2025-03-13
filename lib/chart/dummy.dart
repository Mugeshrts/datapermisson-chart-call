import 'package:flutter/material.dart';
import 'package:tank_monetering/chart/customchart.dart';


class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Level Chart")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Water Level", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: CustomBarChart(), // ✅ Use the chart widget
            ),
          ],
        ),
      ),
    );
  }
}
