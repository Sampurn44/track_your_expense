import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_your_expense/bar%20graph/bar_graph.dart';
import 'package:track_your_expense/data/expense_data.dart';
import 'package:track_your_expense/data_time/date_time_help.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculatemax(ExpenseData value, String sun, String mon, String tues,
      String wed, String thur, String fri, String sat) {
    double? max = 100;
    List<double> values = [
      value.calculatorDailyExpense()[sun] ?? 0,
      value.calculatorDailyExpense()[mon] ?? 0,
      value.calculatorDailyExpense()[tues] ?? 0,
      value.calculatorDailyExpense()[wed] ?? 0,
      value.calculatorDailyExpense()[thur] ?? 0,
      value.calculatorDailyExpense()[fri] ?? 0,
      value.calculatorDailyExpense()[sat] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculatotal(ExpenseData value, String sun, String mon, String tues,
      String wed, String thur, String fri, String sat) {
    // double? max = 100;
    List<double> values = [
      value.calculatorDailyExpense()[sun] ?? 0,
      value.calculatorDailyExpense()[mon] ?? 0,
      value.calculatorDailyExpense()[tues] ?? 0,
      value.calculatorDailyExpense()[wed] ?? 0,
      value.calculatorDailyExpense()[thur] ?? 0,
      value.calculatorDailyExpense()[fri] ?? 0,
      value.calculatorDailyExpense()[sat] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimetoString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Week Total: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.greenAccent),
                ),
              ),
              Text(
                '₹ ${calculatotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              monAmount: value.calculatorDailyExpense()[monday] ?? 0,
              tueAmount: value.calculatorDailyExpense()[tuesday] ?? 0,
              wedAmount: value.calculatorDailyExpense()[wednesday] ?? 0,
              thurAmount: value.calculatorDailyExpense()[thursday] ?? 0,
              friAmount: value.calculatorDailyExpense()[friday] ?? 0,
              satAmount: value.calculatorDailyExpense()[saturday] ?? 0,
              sunAmount: value.calculatorDailyExpense()[sunday] ?? 0,
              maxY: calculatemax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
            ),
          ),
        ],
      ),
    );
  }
}
