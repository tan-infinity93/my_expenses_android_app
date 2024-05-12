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
        ? SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            width: deviceWidth,
            height: deviceHeight,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Card(
                    child: TabBar(
                      controller: tabController,
                      tabs: const [
                        Tab(
                          text: 'Today',
                        ),
                        Tab(
                          text: 'Weekly',
                        ),
                        Tab(
                          text: 'Monthly',
                        ),
                      ],
                      labelColor: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Column(
                            children: [
                              const Expanded(child: BarCharts()),
                              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expense Areas:',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                              const Expanded(child: PieCharts()),
                              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Expenses:',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(17.5),
                                borderRadius: BorderRadius.circular(10.5),
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: DataTable(
                                    headingRowColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.deepPurple
                                    ),
                                    columnSpacing: 35.0,
                                    columns: const [
                                      DataColumn(
                                          label: SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Expense Type',
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                      ),
                                      DataColumn(
                                          label: SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Expense Cost',
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                      ),
                                      DataColumn(
                                          label: SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Expense Date',
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                    rows: const [
                                      DataRow(cells: [
                                        DataCell(
                                            SizedBox(
                                                width: 80,
                                                child: Text('#100')
                                            )
                                        ),
                                        DataCell(
                                            SizedBox(
                                                width: 80,
                                                child: Text('Flutter Basics')
                                            )
                                        ),
                                        DataCell(
                                            SizedBox(
                                                width: 80,
                                                child: Text('David John')
                                            )
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text('ddw'),
                          Text('dd22')
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
        : CircularProgressIndicator();
      }
    );
  }
}
