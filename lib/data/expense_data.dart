import 'dart:math';

import 'package:flutter/material.dart';
import 'package:track_your_expense/data/hive_database.dart';
import 'package:track_your_expense/data_time/date_time_help.dart';
import 'package:track_your_expense/models/expense_dart.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expense
  List<ExpenseItem> overalllist = [];

  //get expense list
  List<ExpenseItem> getallitems() {
    return overalllist;
  }

  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overalllist = db.readData();
    }
  }

  //addition of new item
  void addNewExpense(ExpenseItem newExpense) {
    overalllist.add(newExpense);
    db.saveData(overalllist);
    notifyListeners();
  }

  //delete expense
  void removeExpense(ExpenseItem removeExpense) {
    overalllist.remove(removeExpense);
    db.saveData(overalllist);
    notifyListeners();
  }

  // get weeksday
  String getDayName(DateTime datetime) {
    switch (datetime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //date of start of week
  DateTime startofweekdate() {
    DateTime? startofweek;
    DateTime today = DateTime.now();

    //f
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startofweek = today.subtract(Duration(days: i));
      }
    }
    return startofweek!;
  }

  Map<String, double> calculatorDailyExpense() {
    Map<String, double> dailyExpense = {};
    for (var expense in overalllist) {
      String date = convertDateTimetoString(expense.datetime);
      double amount = double.parse(expense.amount);
      if (dailyExpense.containsKey(date)) {
        double currentamount = dailyExpense[date]!;
        currentamount += amount;
        dailyExpense[date] = currentamount;
      } else {
        dailyExpense.addAll({date: amount});
      }
    }
    return dailyExpense;
  }
}
