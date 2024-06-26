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

Future<void> insertOrderData(Zomato obj) async {
  final localDB = await database;

  // The INSERT method from the database class is used to insert the data in the OrderFood table
  // The Insert method takes 3 parameters i.e TABLE NAME, MAP OF DATA TO BE PASSED, CONFLICT ALGORITHM
  // The CONFLICT ALGORITHM is applied when data with same primary key is inserted
  // The Insert method requires the data in format of a map so we have written the method zomatoMap,
  // In the Zomato class which will return the map of the data present in the given object

  await localDB.insert(
    "OrderFood",
    obj.zomatoMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Zomato>> getOrderData() async {
  final localDB = await database;

  // The Query method from the database class returns a list of Map
  // which conatins all the Data Present in the table OrderFood.

  List<Map<String, dynamic>> orderMap = await localDB.query("OrderFood");

  // Here we will convert the list of map returned from the query method into
  // the list of objects of Zomato

  return List.generate(orderMap.length, (i) {
    return Zomato(
      orderNo: orderMap[i]['orderNo'],
      custName: orderMap[i]['custName'],
      hotelName: orderMap[i]['hotelName'],
      food: orderMap[i]['food'],
      bill: orderMap[i]['bill'],
    );
  });
}

// Delete
Future<void> deleteOrderData(int data) async {
  final localDB = await database;

  /// The delete Method from the database class is used to delete the particular entry from the database
  /// The delete method takes 3 paramaters i.e
  /// 1. Table Name 2. Where  3. WhereArgs
  /// The Where parameter contains the expression on which the delete operation will be performed
  /// i.e Inour case we have specified OrderNo=? i.e delete the entry where orderNo is equal to ?
  /// The ? will be replaced with the argument specified in the  whereArgs Parameter i.e data
  /// so the expression finally becomes => delete the entry where (orderNo = data)

  await localDB.delete(
    "OrderFood",
    where: "OrderNo = ?",
    whereArgs: [data],
  );
}

// Update data

Future<void> updateOrderData(Zomato obj) async {
  final localDB = await database;

  // The UPDATE method from the database is used to update the existing entry from the database
  // The UPDATE method takes 4 parameters i.e
  // 1. Table name
  // 2. Map of updated data
  // 3. where
  // 4. whereArgs

  await localDB.update(
    "OrderFood",
    obj.zomatoMap(),
    where: 'orderNo=?',
    whereArgs: {obj.orderNo},
  );
}

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

  Zomato order3 = Zomato(
      orderNo: 3,
      custName: "Omkar",
      hotelName: "SP Biryani",
      food: "Biryani Rassa",
      bill: 740.90);

  insertOrderData(order3);

  print(await getOrderData());

  deleteOrderData(3);

  // Update Data

  order1 = Zomato(
      orderNo: order1.orderNo,
      custName: order1.custName,
      hotelName: order1.hotelName,
      food: "${order1.food}PaniPuri",
      bill: order1.bill + 150.00);

  updateOrderData(order1);

  print(await getOrderData());
}
