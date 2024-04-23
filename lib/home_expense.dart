import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeExpenses extends StatefulWidget {

  @override
  State<HomeExpenses> createState() => _HomeExpensesState();
}

class _HomeExpensesState extends State<HomeExpenses> {

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    const List expenses = [
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'}
    ];

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white70,
        surfaceTintColor: Colors.white,
        // elevation: 12.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2autowrap text flutter 0, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
              Expanded(child: Text('Welcome Tanmoy:')),
              const Text(
                'Welcome Tanmoy:',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Card(
                color: Colors.deepPurple,
                child: ListTile(
                  leading: Icon(
                    Icons.wallet,
                    color: Colors.white,
                    size: 55.0,
                  ),
                  title: Row(
                    children: [
                      const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                      Text('Total Expenses', style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                         ),
                      )
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 40)),
                      Icon(
                        Icons.currency_rupee,
                        color: Colors.white,
                      ),
                      Text(
                        '10929.92', style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Expanded(
                child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(expenses[index]['expense_cost'].toString()),
                          subtitle: Text(expenses[index]['expense_date']),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
