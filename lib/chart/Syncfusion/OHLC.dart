import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OhlcChartScreen extends StatefulWidget {
  @override
  _OhlcChartScreenState createState() => _OhlcChartScreenState();
}

class _OhlcChartScreenState extends State<OhlcChartScreen> {
  late List<StockData> chartData;
  late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        color: Colors.black,
        textStyle: TextStyle(color: Colors.white),
      ),
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Syncfusion OHLC Chart")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Stock Market Data (OHLC)',
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          tooltipBehavior: _tooltipBehavior,
          trackballBehavior: _trackballBehavior,
          zoomPanBehavior: _zoomPanBehavior,
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            labelFormat: '{value} USD',
            axisLine: AxisLine(width: 2),
            majorGridLines: MajorGridLines(dashArray: <double>[5, 5]),
          ),
          series: <CartesianSeries>[
            HiloOpenCloseSeries<StockData, String>(
              name: "Stock Price",
              dataSource: chartData,
              xValueMapper: (StockData stock, _) => stock.date,
              lowValueMapper: (StockData stock, _) => stock.low,
              highValueMapper: (StockData stock, _) => stock.high,
              openValueMapper: (StockData stock, _) => stock.open,
              closeValueMapper: (StockData stock, _) => stock.close,
              bearColor: Colors.red, // Color when stock falls
              bullColor: Colors.green, // Color when stock rises
            ),
          ],
        ),
      ),
    );
  }

  List<StockData> getChartData() {
    return [
      StockData('Jan', 120, 150, 110, 140),
      StockData('Feb', 130, 160, 120, 150),
      StockData('Mar', 140, 170, 130, 160),
      StockData('Apr', 110, 110, 140, 150),
      StockData('May', 160, 190, 150, 180),
      StockData('Jun', 170, 200, 160, 190),
    ];
  }
}

class StockData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;

  StockData(this.date, this.open, this.high, this.low, this.close);
}