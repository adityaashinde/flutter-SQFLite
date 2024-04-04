import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Zomato {
  final int orderNo;
  final String custName;
  final String hotelName;
  final String food;
  final double bill;

  Zomato({
    required this.orderNo,
    required this.custName,
    required this.hotelName,
    required this.food,
    required this.bill,
  });

  Map<String, dynamic> zomatoMap() {
    return {
      'orderNo': orderNo,
      'custName': custName,
      'hotelName': hotelName,
      'food': food,
      'bill': bill
    };
  }

  @override
  String toString() {
    return '{orderNo:$orderNo,custName:$custName, hotelName:$hotelName, food:$food, bill:$bill}';
  }
}

dynamic database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), "ZomatoDB.db"),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE OrderFood(
        orderNo INTEGER PRIMARY KEY,
        custName TEXT,
        hotelName TEXT,
        food TEXT,
        bill REAL
        )
        ''');
    },
  );
}
