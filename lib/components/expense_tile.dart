import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime datetime;
  void Function(BuildContext)? deleteTapped;
  ExpenseTile(
      {required this.amount,
      required this.datetime,
      required this.name,
      required this.deleteTapped,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(4),
            backgroundColor: Colors.red,
          )
        ]),
        child: ListTile(
          tileColor: Colors.black,
          title: Text(
            name,
            style: const TextStyle(color: Colors.greenAccent),
          ),
          subtitle: Text(
            '${datetime.day}/${datetime.month}/${datetime.year}',
            style: const TextStyle(color: Colors.greenAccent),
          ),
          trailing: Text(
            '₹ $amount',
            style: const TextStyle(color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}
