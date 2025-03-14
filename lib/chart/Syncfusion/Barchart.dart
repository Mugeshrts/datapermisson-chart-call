import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartScreen extends StatefulWidget {
  @override
  _BarChartScreenState createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  List<SalesData> chartData = [
    SalesData('Jan', 30),
    SalesData('Feb', 45),
    SalesData('Mar', 25),
    SalesData('Apr', 60),
    SalesData('May', 40),
    SalesData('Jun', 80),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Syncfusion Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          title: ChartTitle(text: 'Monthly Sales Data'),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enablePinching: true,
            enableDoubleTapZooming: true,
          ),
          
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}K',
            axisLine: AxisLine(width: 2),
          ),
          series: <CartesianSeries>[
            ColumnSeries<SalesData, String>(
              name: "Sales",
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5), // Rounded Corners
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                borderRadius: 8,
                color: Colors.orange,
              ),
              markerSettings: MarkerSettings(
                isVisible: true,
                shape: DataMarkerType.circle,
                width: 10,
                height: 10,
                borderColor: Colors.red,
                borderWidth: 2,
              ),
            ),
          ],
           trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipSettings: InteractiveTooltip(
                  enable: true,
                  color: Colors.black,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              
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
