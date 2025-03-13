import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class TankScreen1 extends StatefulWidget {
  @override
  _TankScreen1State createState() => _TankScreen1State();
}

class _TankScreen1State extends State<TankScreen1> {
  int selectedTab = 1; // 1: Bar Chart, 2: Table View
  DateTime selectedDate = DateTime.now();
  bool showPercentage = true;
  bool showTime = true;

  /// 📅 Format date to "DD.MM.YYYY"
  String get formattedDate =>
      "${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text("Tank 1", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _pickDate,
          ),
        ],
      ),
      body: Column(
        children: [
          /// 🔹 Custom Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.blue.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tabItem("All", 0),
                _tabItem("Bar chart", 1, isSelected: selectedTab == 1),
                _tabItem("Table view", 2, isSelected: selectedTab == 2),
              ],
            ),
          ),

          /// 🔹 Bar Chart + Line Graph
          SizedBox(
            height:
                MediaQuery.of(context).size.height *
                0.4, // Half of the screen height
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: selectedTab == 1 ? _buildChart() : _buildTableView(),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Tab Button Widget
  Widget _tabItem(String text, int index, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isSelected)
            Container(
              height: 3,
              width: 50,
              color: Colors.white,
              margin: EdgeInsets.only(top: 4),
            ),
        ],
      ),
    );
  }


  /// 📊 Bar Chart + Line Graph Overlay
  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Date Selector
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left, color: Colors.blue),
                onPressed:
                    () => setState(
                      () =>
                          selectedDate = selectedDate.subtract(
                            Duration(days: 1),
                          ),
                    ),
              ),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right, color: Colors.blue),
                onPressed:
                    () => setState(
                      () => selectedDate = selectedDate.add(Duration(days: 1)),
                    ),
              ),
            ],
          ),
        ),

        /// 🔹 Water Level Title + Checkboxes
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                "Water Level",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // _checkbox(
              //   "Percentage",
              //   showPercentage,
              //   (v) => setState(() => showPercentage = v!),
              // ),
              // _checkbox("Time", showTime, (v) => setState(() => showTime = v!)),
            ],
          ),
        ),

        SizedBox(height: 5),

        /// 🔹 Bar Chart (Half-Screen)
        SizedBox(
          height:
              MediaQuery.of(context).size.height *
              0.2, // Half of the screen height
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: true),
              gridData: FlGridData(
                drawHorizontalLine: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine:
                    (value) => FlLine(
                      color: Colors.grey.withOpacity(
                        0.5,
                      ), // Customize horizontal line color
                      strokeWidth: 1,
                    ),
              ),
              barGroups: [
                _barData(0, 50),
                _barData(1, 45),
                _barData(2, 60),
                _barData(3, 50),
                _barData(4, 90),
                _barData(5, 40),
                _barData(6, 35),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, _) => _bottomTitle(v.toInt()),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _leftTitle,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 📊 Bar Data

  BarChartGroupData _barData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.lightBlueAccent,
          width: 14,
          borderRadius: BorderRadius.circular(3),
          gradient: LinearGradient(
            // Gradient Effect
            colors: [
              const Color.fromARGB(255, 7, 135, 240),
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ],
    );
  }

  /// 📅 Bottom Labels
  Widget _bottomTitle(int value) {
    List<String> times = [
      "09:00",
      "12:10",
      "13:40",
      "16:00",
      "17:05",
      "18:10",
      "20:00",
    ];
    return Text(times[value], style: TextStyle(fontSize: 12));
  }

  /// 📏 Left Labels (Fixed Signature)
  Widget _leftTitle(double value, TitleMeta meta) {
    return Text(value.toInt().toString(), style: TextStyle(fontSize: 10));
  }

  /// 🔘 Checkbox Widget
  Widget _checkbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Checkbox(value: value, onChanged: onChanged), Text(label)],
    );
  }

  /// 📋 Table View (Placeholder)
  Widget _buildTableView() {
    return Center(
      child: Text(
        "Table View Coming Soon!",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 📅 Date Picker Dialog
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }
}
