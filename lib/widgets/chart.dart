import 'package:flutter/material.dart';

import '../modals/transaction.dart';
import './chart_builder.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);
  List<Map<String, dynamic>> get groupedTrasactionValues {
    return List.generate(7, (index) {
      var sumForOneDay = 0.0;
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      for (var tx in _recentTransactions) {
        if (tx.dateTime.day == weekDay.day &&
            tx.dateTime.month == weekDay.month &&
            tx.dateTime.year == weekDay.year) {
          sumForOneDay += tx.price;
        }
      }
      print(
          '${DateFormat.E().format(weekDay).substring(0, 1)} check and also ${sumForOneDay}');
      return {
        "Day": DateFormat.E().format(weekDay).substring(0, 1),
        "Sum": sumForOneDay,
      };
    });
  }

  double get totalAmountForTheWeek {
    return groupedTrasactionValues.fold(
        0.0, (sum, element) => sum + element["Sum"]);
  }

  @override
  Widget build(BuildContext context) {
    print(totalAmountForTheWeek);
    return Container(
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTrasactionValues.map((e) {
              return ChartBuilder(
                e["Day"],
                e["Sum"],
                (e["Sum"] / totalAmountForTheWeek),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
