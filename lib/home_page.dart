import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:track_your_expense/components/expense_summary.dart';
import 'package:track_your_expense/components/expense_tile.dart';
import 'package:track_your_expense/data/expense_data.dart';
import 'package:track_your_expense/models/expense_dart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final newNameController = TextEditingController();
  final newAmountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 1, 106, 29),
              title: const Text(
                "Add New Expense",
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: newNameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // Add other InputDecoration properties as needed
                    ),
                  ),
                  TextField(
                    controller: newAmountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // Add other InputDecoration properties as needed
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ));
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).removeExpense(expense);
  }

  void save() {
    if (newAmountController.text.isEmpty && newNameController.text.isEmpty) {
    } else {
      ExpenseItem newExpense = ExpenseItem(
          amount: newAmountController.text,
          datetime: DateTime.now(),
          name: newNameController.text);
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newNameController.clear();
    newAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: const Color.fromARGB(255, 1, 106, 29),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpenseSummary(startOfWeek: value.startofweekdate()),
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getallitems().length,
                itemBuilder: (context, index) => ExpenseTile(
                      amount: value.getallitems()[index].amount,
                      datetime: value.getallitems()[index].datetime,
                      name: value.getallitems()[index].name,
                      deleteTapped: (BuildContext) => {
                        deleteExpense(
                          value.getallitems()[index],
                        ),
                      },
                    )),
          ],
        ),
      ),
    );
  }
}
