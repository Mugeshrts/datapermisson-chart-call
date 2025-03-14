import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartScreen extends StatefulWidget {
  @override
  _LineChartScreenState createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  List<SalesData> chartData = [
    SalesData('Jan', 30),
    SalesData('Feb', 45),
    SalesData('Mar', 25),
    SalesData('Apr', 60),
    SalesData('May', 40),
    SalesData('Jun', 80),
  ];


List<SalesData> salesDataB = [
    SalesData('Jan', 40),
    SalesData('Feb', 55),
    SalesData('Mar', 29),
    SalesData('Apr', 66),
    SalesData('May', 44),
    SalesData('Jun', 82),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Syncfusion Line Chart")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          title: ChartTitle(text: 'Monthly Sales Data'),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          zoomPanBehavior: ZoomPanBehavior(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    enablePinching: true,
    enablePanning: true,
    enableDoubleTapZooming: true,
  ),
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}K',
            axisLine: AxisLine(width: 2),
          ),
          series: <CartesianSeries>[
            LineSeries<SalesData, String>(
              name: "Sales",
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              width: 4,
              // dashArray: <double>[5, 3], // Dashed Line
              dataLabelSettings: DataLabelSettings(
              isVisible: true,
              color: Colors.amber,
              borderRadius: 5,
            
              ),
              enableTooltip: true,
              color: Colors.green,
               
              markerSettings: MarkerSettings(
                isVisible: true,
                shape: DataMarkerType.circle,
                 width: 10,
                 height: 10,
                 borderColor: Colors.red,
                 borderWidth: 2,
              ),
            
            ),
             LineSeries<SalesData, String>(
    name: "Product B",
    dataSource: salesDataB,
    xValueMapper: (SalesData sales, _) => sales.month,
    yValueMapper: (SalesData sales, _) => sales.sales,
    color: Colors.red,
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