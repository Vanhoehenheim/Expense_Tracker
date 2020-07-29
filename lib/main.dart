import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

import 'modals/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Expense(),
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(15, 28, 46, 1),
        accentColor: Color.fromRGBO(173, 255, 233, 1),
        primarySwatch: Colors.indigo,
        primaryColor: Color.fromRGBO(29, 53, 87, 1),
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Color.fromRGBO(15, 28, 46, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "Prata",
                // fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromRGBO(241, 250, 238, 1),
              ),
              subtitle1: TextStyle(
                fontFamily: "Poppins",
                // fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color.fromRGBO(241, 250, 238, 0.7),
              ),
              headline2: TextStyle(
                color: Color.fromRGBO(173, 255, 233, 1),
                fontSize: 19,
                fontFamily: "Poppins",
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(241, 250, 238, 1),
                fontSize: 15,
                fontFamily: "Poppins",
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "Prata",
                    // fontWeight: FontWeight.bold,
                    fontSize: 27),
              ),
        ),
      ),
    );
  }
}

class Expense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   dateTime: DateTime.now(),
    //   itemID: "123",
    //   price: 50,
    //   title: "Shoes",
    // ),
    // Transaction(
    //   dateTime: DateTime.now(),
    //   itemID: "124",
    //   price: 100,
    //   title: "Pokemon",
    // ),
  ];

  List<Transaction> get _recentTx {
    return _transactions
        .where(
          (element) => element.dateTime.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void addNewTx({String txTitle, double txPrice, DateTime txDate}) {
    final newTx = Transaction(
        dateTime: txDate,
        itemID: DateTime.now().toString(),
        price: txPrice,
        title: txTitle);

    setState(
      () {
        _transactions.add(newTx);
      },
    );
  }

  void deleteTx(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.itemID == id);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(15, 28, 46, 1),
      context: ctx,
      builder: (_) {
        return NewTransaction(addNewTx);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Expense Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
              // width: 20,
              height: 120,
              child: Chart(_recentTx),
            ),
            TransactionList(_transactions, deleteTx),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
