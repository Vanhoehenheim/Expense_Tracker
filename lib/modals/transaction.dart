import 'package:flutter/foundation.dart';

class Transaction {
  final String itemID;
  final String title;
  final double price;
  final DateTime dateTime;

  Transaction({
    @required this.dateTime,
    @required this.itemID,
    @required this.price,
    @required this.title,
  });
}
