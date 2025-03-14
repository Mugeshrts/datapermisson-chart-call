import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Syncfusion Area Chart',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AreaChartScreen(),
    );
  }
}

class AreaChartScreen extends StatefulWidget {
  @override
  _AreaChartScreenState createState() => _AreaChartScreenState();
}

class _AreaChartScreenState extends State<AreaChartScreen> {
  List<SalesData> chartDataA = [
    SalesData('Jan', 30),
    SalesData('Feb', 45),
    SalesData('Mar', 25),
    SalesData('Apr', 60),
    SalesData('May', 40),
    SalesData('Jun', 80),
  ];

  List<SalesData> chartDataB = [
    SalesData('Jan', 20),
    SalesData('Feb', 35),
    SalesData('Mar', 15),
    SalesData('Apr', 50),
    SalesData('May', 30),
    SalesData('Jun', 70),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advanced Syncfusion Area Chart")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Monthly Sales Data',
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            color: Colors.black,
            textStyle: TextStyle(color: Colors.white, fontSize: 12),
            borderColor: Colors.blue,
            borderWidth: 2,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            enableDoubleTapZooming: true,
            enableSelectionZooming: true,
          ),
          trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipSettings: InteractiveTooltip(
              enable: true,
              color: Colors.blueAccent,
              textStyle: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}K',
            axisLine: AxisLine(width: 2),
            majorGridLines: MajorGridLines(dashArray: <double>[5, 5]),
          ),
          series: <CartesianSeries>[
            // First Dataset (Main Sales Data)
            SplineAreaSeries<SalesData, String>(
              name: "Product A",
              dataSource: chartDataA,
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              gradient: LinearGradient(
                colors: [Colors.blue.withOpacity(0.6), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderColor: Colors.blue,
              borderWidth: 3,
              borderDrawMode: BorderDrawMode.excludeBottom,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              markerSettings: MarkerSettings(
                isVisible: true,
                shape: DataMarkerType.circle,
                width: 8,
                height: 8,
                borderColor: Colors.blue,
                borderWidth: 2,
              ),
            ),

            // Second Dataset (Comparison)
            SplineAreaSeries<SalesData, String>(
              name: "Product B",
              dataSource: chartDataB,
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              gradient: LinearGradient(
                colors: [Colors.red.withOpacity(0.6), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderColor: Colors.red,
              borderWidth: 3,
              borderDrawMode: BorderDrawMode.excludeBottom,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              markerSettings: MarkerSettings(
                isVisible: true,
                shape: DataMarkerType.circle,
                width: 8,
                height: 8,
                borderColor: Colors.red,
                borderWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  final String month;
  final double sales;
  SalesData(this.month, this.sales);
}
