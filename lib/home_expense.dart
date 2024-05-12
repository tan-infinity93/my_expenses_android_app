

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_expenses/rest_api.dart';
import 'package:my_expenses/utils.dart';

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
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'},
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'},
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'},
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'},
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'},
      {'expense_cost': 234.45, 'expense_date': '2024-04-23'},
    ];

    double totalExpense = 0.0;

    var dates = getCurrentAndNextDate();
    print(dates);
    String startDate = dates[0];
    String endDate = dates[1];

    Future getExpensesData (String startDate, String endDate) async {
      final url = 'https://flask-expenses.fly.dev/expenses/v1/manage-get?startdate=$startDate&enddate=$endDate';
      final headers = {
        'Content-Type': 'application/json'
      };
      final payload = {'X': 'R'};

      var restApiAdapter = RestAPIAdapter();
      var apiResponse = await restApiAdapter.getRequest(url, headers, payload);
      var responseBody = apiResponse[0];
      var responseCode = apiResponse[1];

      print(url);
      print(responseBody);
      print(responseCode);

      var expensesData = jsonDecode(responseBody)['expenses'];
      totalExpense = getExpensesSum(expensesData);

      return [expensesData, totalExpense];
    };

    return FutureBuilder(
      // future: dartSleeper(),
        future: getExpensesData(startDate, endDate),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('no data');
          }
          print(snapshot.data);
          // print(getExpensesSum(snapshot.data));

          // totalExpense = getExpensesSum(snapshot.data);
          // print(totalExpense);

          return snapshot.hasData
              ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
                const Text(
                  'Welcome Tanmoy:',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Material(
                  child: InkWell(
                    onTap: (){},
                    onLongPress: (){},
                    // splashColor: Colors.deepPurple,
                    radius: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: const Card(
                        elevation: 5.0,
                        color: Colors.deepPurple,
                        child: ListTile(
                          leading: Icon(
                            Icons.wallet,
                            color: Colors.white,
                            size: 55.0,
                          ),
                          title: Row(
                            children: [
                              Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                              Text('Total Expenses', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30
                              ),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 40)),
                              Icon(
                                Icons.currency_rupee,
                                color: Colors.white,
                              ),
                              Text(
                                'snapshot.data[1]', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                const Text(
                  "Today's Expenses:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      itemCount: snapshot.data[0].length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                      color: Colors.deepPurple,
                                      width: deviceWidth * 0.15,
                                      height: deviceHeight * 0.15,
                                      child: const Icon(
                                        Icons.coffee,
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                                title: Text('Type: ${snapshot.data[0][index]['expense_type']}'),
                                subtitle: Text('Date: ${snapshot.data[0][index]['timestamp']}'),
                                trailing: Text(
                                    'Cost: ${snapshot.data[0][index]['expense_cost'].toString()}',
                                    style: const TextStyle(
                                      // color: Colors.white,
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5))
                          ],
                        );
                      }
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10))
              ],
            ),
          )
              : const CircularProgressIndicator();
        }
    );
  }
}
