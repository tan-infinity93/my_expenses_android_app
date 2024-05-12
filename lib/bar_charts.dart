import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarCharts extends StatefulWidget {
  const BarCharts({super.key});

  @override
  State<BarCharts> createState() => _BarChartsState();
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class _BarChartsState extends State<BarCharts> {

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 35),
      ChartData(2, 23),
      ChartData(3, 34),
      ChartData(4, 25),
      ChartData(5, 40)
    ];
    return Scaffold(
      body: Container(
        child: SfCartesianChart(
            series: <CartesianSeries<ChartData, int>>[
              // Renders column chart
              ColumnSeries<ChartData, int>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y
              )
            ]
        ),
      ),
    );
  }
}
