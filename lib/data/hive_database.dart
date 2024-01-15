import 'package:hive/hive.dart';
import 'package:track_your_expense/data/expense_data.dart';
import 'package:track_your_expense/models/expense_dart.dart';

class HiveDataBase {
  final _mybox = Hive.box("expense_tracker_database");

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseformatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.datetime,
      ];
      allExpenseformatted.add(expenseFormatted);
    }
    _mybox.put("ALL_EXPENSE", allExpenseformatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _mybox.get("ALL_EXPENSE") ?? [];
    List<ExpenseItem> allExpense = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense =
          ExpenseItem(amount: amount, datetime: dateTime, name: name);

      allExpense.add(expense);
    }
    return allExpense;
  }
}
