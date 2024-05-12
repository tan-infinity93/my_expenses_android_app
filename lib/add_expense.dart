
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_expenses/rest_api.dart';
import 'package:my_expenses/utils.dart';

class AddExpenses extends StatefulWidget {

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final TextEditingController expenseCostController = TextEditingController();
  final TextEditingController expenseDateController = TextEditingController();
  String selectedValue = "MEDICAL";
  final List<DropdownMenuItem<String>> expenseCategories = [
    DropdownMenuItem(child: Text("MEDICAL"),value: "MEDICAL"),
    DropdownMenuItem(child: Text("MARKET"),value: "MARKET"),
    DropdownMenuItem(child: Text("TRAVEL"),value: "TRAVEL"),
    DropdownMenuItem(child: Text("EDUCATION"),value: "EDUCATION"),
    DropdownMenuItem(child: Text("DEBIT EMI"),value: "DEBIT EMI"),
    DropdownMenuItem(child: Text("CREDIT EMI"),value: "CREDIT EMI"),
    DropdownMenuItem(child: Text("LOAN EMI"),value: "LOAN EMI"),
    DropdownMenuItem(child: Text("INTERNET"),value: "INTERNET"),
    DropdownMenuItem(child: Text("ELECTRICITY"),value: "ELECTRICITY"),
    DropdownMenuItem(child: Text("MUTUAL_FUNDS"),value: "MUTUAL_FUNDS"),
    DropdownMenuItem(child: Text("GROCERY"),value: "GROCERY"),
    DropdownMenuItem(child: Text("ONLINE_FOOD/APPS"),value: "ONLINE_FOOD/APPS"),
    DropdownMenuItem(child: Text("CLOTHES"),value: "CLOTHES"),
    DropdownMenuItem(child: Text("ONE_TIME"),value: "ONE_TIME"),
    DropdownMenuItem(child: Text("HOUSE_RENT"),value: "HOUSE_RENT"),
    DropdownMenuItem(child: Text("MOVIE_TICKETS"),value: "MOVIE_TICKETS"),
    DropdownMenuItem(child: Text("RESTAURANT"),value: "RESTAURANT"),
    DropdownMenuItem(child: Text("VACATION/TRIPS"),value: "VACATION/TRIPS"),
    DropdownMenuItem(child: Text("SOVEREIGN_GOLD_BONDS"),value: "SOVEREIGN_GOLD_BONDS"),
    DropdownMenuItem(child: Text("ONLINE_SHOPPING"),value: "ONLINE_SHOPPING"),
    DropdownMenuItem(child: Text("STATIONERY"),value: "STATIONERY"),
    DropdownMenuItem(child: Text("HAIR_CUT"),value: "HAIR_CUT"),
    DropdownMenuItem(child: Text("OTHER_BONDS"),value: "OTHER_BONDS"),
    DropdownMenuItem(child: Text("DISASTER_RELIEF"),value: "DISASTER_RELIEF"),
    DropdownMenuItem(child: Text("GAS_CYLINDER"),value: "GAS_CYLINDER"),
    DropdownMenuItem(child: Text("TURTLE_FOOD"),value: "TURTLE_FOOD"),
    DropdownMenuItem(child: Text("SHARES"),value: "SHARES"),
    DropdownMenuItem(child: Text("KUKASADAN_MISCELLANEOUS"),value: "KUKASADAN_MISCELLANEOUS"),
    DropdownMenuItem(child: Text("GIFTING"),value: "GIFTING")
  ];
  bool showDialog = false;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: deviceWidth,
        height: deviceHeight * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
            const Text(
              'Add Expenses:',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.wallet),
                border: OutlineInputBorder(),
                labelText: 'Enter Expense Amount:',
              ),
              controller: expenseCostController,
              keyboardType: TextInputType.number,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
            TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  labelText: 'Enter Expense Date:',
                ),
                controller: expenseDateController,
                keyboardType: TextInputType.none,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if(pickedDate != null){
                    print(pickedDate);
                    expenseDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                }
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
            DropdownButtonFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.list_alt),
                  border: OutlineInputBorder(),
                  labelText: 'Enter Expense Category:',
                ),
                value: selectedValue,
                items: expenseCategories,
                onChanged: (clickedItem) {
                  setState(() {
                    selectedValue = clickedItem!;
                  });
                }
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(deviceWidth * 0.25, deviceHeight * 0.06)
                    ),
                  ),
                  onPressed: () async {
                    print(expenseCostController.text);
                    print(expenseDateController.text);
                    print(selectedValue);

                    var expenseCost = expenseCostController.text;
                    var expenseDate = expenseDateController.text;
                    var expenseType = selectedValue;

                    final url = 'https://flask-expenses.fly.dev/expenses/v1/manage-add';
                    final headers = {
                      'Content-Type': 'application/json'
                    };
                    final payload = {
                      'expense_type': expenseType,
                      'expense_cost': expenseCost,
                      'expense_date': expenseDate
                    };

                    var restApiAdapter = RestAPIAdapter();
                    var apiResponse = await restApiAdapter.postRequest(url, headers, payload);

                    var responseBody = apiResponse[0];
                    var responseCode = apiResponse[1];

                    print(url);
                    print(responseBody);
                    print(responseCode);

                    if (responseCode == 200) {
                      const snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 500),
                          content: Text("Expense added"),
                          dismissDirection: DismissDirection.none
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    // setState(() {
                    //   showDialog = false;
                    // });
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          ],
        )
      ),
    );
  }
}