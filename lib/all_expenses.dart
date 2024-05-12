import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:my_expenses/bar_charts.dart';
import 'package:my_expenses/pie_charts.dart';

class AllExpenses extends StatefulWidget {

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> with TickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future dartSleeper() {
    return Future.delayed(const Duration(seconds: 2), () => "1.x");
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: dartSleeper(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('no data');
        }
        print(snapshot.data);

        return snapshot.hasData
        ? SingleChildScrollView()
        : CircularProgressIndicator();
      }
    );
  }
}
