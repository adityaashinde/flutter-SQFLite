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

Future<void> insertOrderData(Zomato obj) async {}
void main() async {
  // We have commented the runApp method so we will have to call the
  // ensureInitialized() method from the WidgetsFlutterBinding class

  WidgetsFlutterBinding.ensureInitialized();

  // The openDatabase method of the Database class is called here this method Returns an object of Database
  // We will assign this object of Database to the global variable database.
  // We have passed this openDatabase class 3 parameters i.e.
  // 1. path
  // 2. version
  // 3. onCreate

  // The path is the path where the databases are stored it will be different fot the Emulators and Real Device
  // The version will be the version of the current Database
  // onCreate callback will contain the steps which we want to perform when our database is created
  // In our case we have created a table OrderFood.
  // The OrderFood table contains 4 columns i.e
  // orderNo, custName, hotelName, food, bill,
  // In the SSQFLite to specify the datatype double we have to use a datatype real
  // The orderNo id the Primary Key.

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

  // Insert Data

  Zomato order1 = Zomato(
      orderNo: 1,
      custName: "Amol",
      hotelName: "Shree Vej",
      food: "Buttor Panner & Shev Bhaji",
      bill: 540.80);

  insertOrderData(order1);

  Zomato order2 = Zomato(
      orderNo: 2,
      custName: "SAI",
      hotelName: "Garva Hotel",
      food: "Chiken Grevy and Spl Biryani",
      bill: 740.90);

  insertOrderData(order2);
}
