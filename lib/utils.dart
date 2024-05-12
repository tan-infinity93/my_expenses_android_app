import 'dart:ffi';

import 'package:intl/intl.dart';

List<dynamic> getCurrentAndNextDate () {
  var startDate = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');

  startDate = DateTime(startDate.year, startDate.month, startDate.day - 5);
  String formattedStartDate = formatter.format(startDate);
  var endDate = DateTime(startDate.year, startDate.month, startDate.day + 5);
  String formattedEndDate = formatter.format(endDate);

  return [formattedStartDate, formattedEndDate];
}

double getExpensesSum (expensesData) {
  var total = 0.0;
  expensesData.forEach((data) => {
    total += data['expense_cost']
  });
  return total;
}