import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBuilder extends StatelessWidget {
  final String label;
  final double amount;
  final double pct;
  ChartBuilder(this.label, this.amount, this.pct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        // SizedBox(
        //   height: 20,
        // ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 7,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(173, 255, 233, 1),
                  border: Border.fromBorderSide(
                    BorderSide(
                      width: 1,
                      color: Color.fromRGBO(173, 255, 233, 1),
                    ),
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: pct >= 0 ? (1 - pct) : 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.fromBorderSide(
                      BorderSide(
                        width: 0.5,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(5),
                      bottom: Radius.circular(4),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }
}
