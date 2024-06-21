import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:record/sql/model/statistics_data_modal.dart';

class Chart extends StatefulWidget {
  final Color leftBarColor = Color(0xFF2a9d8f);
  final Color rightBarColor = Color(0xFFE80054);
  List<StatisticsBaseDataModal> list = [];

  Chart({super.key, required this.list});

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  final double width = 7;
  final titles = [
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ];

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    // final items = [
    //   makeGroupData(0, 11, 12),
    //   makeGroupData(1, 16, 12),
    //   makeGroupData(2, 18, 5),
    //   makeGroupData(3, 20, 16),
    //   makeGroupData(4, 17, 6),
    //   makeGroupData(5, 19, 125),
    //   makeGroupData(6, 10, 1.5),
    //   makeGroupData(8, 10, 1.5),
    //   makeGroupData(9, 10, 1.5),
    //   makeGroupData(10, 10, 1.5),
    //   makeGroupData(11, 10, 1.5),
    // ];

    // rawBarGroups = items;
    // showingBarGroups = rawBarGroups;
  }

  @override
  void didUpdateWidget(covariant Chart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _renderData();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: showingBarGroups,
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  void _renderData() {
    List<BarChartGroupData> items = [];
    for (var data in widget.list.indexed) {
      items.add(makeGroupData(
        data.$1,
        (data.$2.outTotal * 100).roundToDouble() / 100,
        (data.$2.inTotal * 100).roundToDouble() / 100,
      ));
    }

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }
}
