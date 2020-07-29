import 'package:flutter/material.dart';

import '../modals/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTransaction;
  TransactionList(this._transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 400,
      child: _transactions.isNotEmpty
          ? ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Container(
                        child: Text(
                          _transactions[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(_transactions[index].dateTime),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      trailing: IconButton(
                        iconSize: 26,
                        color: Theme.of(context).errorColor,
                        icon: Icon(Icons.delete_outline),
                        onPressed: () =>
                            deleteTransaction(_transactions[index].itemID),
                      ),
                      leading: Container(
                        width: 60,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "₹${_transactions[index].price}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Help me fill up the list :)",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Image.asset(
                  "assets/img/Untitled-1.png",
                ),
              ],
            ),
    );
  }
}
