import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController expenseDateController = TextEditingController();
  // final List<DropdownMenuItem<String>> expenseCategories = [
  //   "MEDICAL", "MARKET", "TRAVEL", "EDUCATION", "EMI", "INTERNET",
  //   "ELECTRICITY", "MUTUAL_FUNDS", "GROCERY", "ONLINE_FOOD/APPS", "CLOTHES", "ONE_TIME",
  //   "MOVIE_TICKETS", "RESTAURANT", "SOVEREIGN_GOLD_BONDS", "OTHER_BONDS", "DISASTER_RELIEF",
  //   "GAS_CYLINDER", "TURTLE_FOOD", "SHARES", "KUKASADAN_MISCELLANEOUS", "GIFTING"
  // ];
  String selectedValue = "MEDICAL";
  final List<DropdownMenuItem<String>> expenseCategories = [
    DropdownMenuItem(child: Text("MEDICAL"),value: "MEDICAL"),
    DropdownMenuItem(child: Text("MARKET"),value: "MARKET"),
    DropdownMenuItem(child: Text("TRAVEL"),value: "TRAVEL"),
    DropdownMenuItem(child: Text("EDUCATION"),value: "EDUCATION"),
    DropdownMenuItem(child: Text("EMI"),value: "EMI"),
    DropdownMenuItem(child: Text("INTERNET"),value: "INTERNET"),
    DropdownMenuItem(child: Text("ELECTRICITY"),value: "ELECTRICITY"),
    DropdownMenuItem(child: Text("MUTUAL_FUNDS"),value: "MUTUAL_FUNDS"),
    DropdownMenuItem(child: Text("GROCERY"),value: "GROCERY"),
    DropdownMenuItem(child: Text("ONLINE_FOOD/APPS"),value: "ONLINE_FOOD/APPS"),
    DropdownMenuItem(child: Text("CLOTHES"),value: "CLOTHES"),
    DropdownMenuItem(child: Text("ONE_TIME"),value: "ONE_TIME"),
    DropdownMenuItem(child: Text("MOVIE_TICKETS"),value: "MOVIE_TICKETS"),
    DropdownMenuItem(child: Text("RESTAURANT"),value: "RESTAURANT"),
    DropdownMenuItem(child: Text("SOVEREIGN_GOLD_BONDS"),value: "SOVEREIGN_GOLD_BONDS"),
    DropdownMenuItem(child: Text("OTHER_BONDS"),value: "OTHER_BONDS"),
    DropdownMenuItem(child: Text("DISASTER_RELIEF"),value: "DISASTER_RELIEF"),
    DropdownMenuItem(child: Text("GAS_CYLINDER"),value: "GAS_CYLINDER"),
    DropdownMenuItem(child: Text("TURTLE_FOOD"),value: "TURTLE_FOOD"),
    DropdownMenuItem(child: Text("SHARES"),value: "SHARES"),
    DropdownMenuItem(child: Text("KUKASADAN_MISCELLANEOUS"),value: "KUKASADAN_MISCELLANEOUS"),
    DropdownMenuItem(child: Text("GIFTING"),value: "GIFTING")
  ];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white70,
        surfaceTintColor: Colors.white,
        // elevation: 12.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                controller: expenseController,
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
                          Size(deviceWidth * 0.30, deviceHeight * 0.06)
                      ),
                    ),
                    onPressed: () { },
                    child: Text('Submit'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
