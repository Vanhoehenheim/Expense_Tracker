import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTxGen;

  NewTransaction(this.newTxGen);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final priceController = TextEditingController();

  var chosenDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(priceController.text);
    final enteredDate = chosenDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }
    widget.newTxGen(
      txTitle: enteredTitle,
      txPrice: enteredAmount,
      txDate: enteredDate,
    );
    Navigator.of(context).pop();
  }

  void dateChooser() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        chosenDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Color.fromRGBO(15, 28, 46, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Card(
        elevation: 0,
        color: Color.fromRGBO(15, 28, 46, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).accentColor, width: 3),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelText: "Title",
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).accentColor, width: 3),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelText: "Price",
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  controller: priceController,
                  onSubmitted: (_) => submitData(),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    (chosenDate == null)
                        ? "No Date Chosen"
                        : DateFormat.yMd().format(chosenDate),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  FlatButton(
                    onPressed: () => dateChooser(),
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 1,
                    ),
                  ),
                  // color: Theme.of(context).accentColor,
                  onPressed: () => submitData(),
                  child: Text(
                    "Add New Transaction",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  textColor: Theme.of(context).accentColor),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
