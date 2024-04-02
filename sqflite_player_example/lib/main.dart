import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic database;

class Player {
  final String name;
  final int jerNo;
  final int runs;
  final double avg;

  Player({
    required this.name,
    required this.jerNo,
    required this.runs,
    required this.avg,
  });
}

insertPlayerData(Player obj) async {
  // assign the database to the local variable localDB

  final localDB = await database;

  // The insert method from the database class is used to insert the data in the player table.

  // The insert method takes 3 parameters i.e TABLE NAME, MAP OF DATA TO BE PASSED, CONFLICT ALGORITHM.

  //The CONFLICT ALGORITHM is applied when data with same PRIMARY KEY is inserted.

  await localDB.insert(
    "Player",
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

void main() async {
  // We have commented THE runApp method so we will to call
  // The ensureInitialized method from the WidgetFlutterBinding class

  WidgetsFlutterBinding.ensureInitialized();

  /*
  The openDatabase method of the Database class is called here this method returns an Object of Database

  We will assign this object of Database to the global variable database.

  We have passed the openDatabase class 3 parameters i.e.
  1. path
  2. version
  3. onCreate 

  The path is the Path where the database are stored it will be different for emulators and real device.

  getDatabasesPath() method will give the default path for the databases for the respective device.

  The version will be the version of the current database.

  onCreate callback will contain the steps which we want to perform when our database is created.

  In our case we have created a table Player.

  The Player table contains 4 columns i.e name, jerNo, runs, avg.
  The jerNo is the PRIMARY KEY.
  */

  database = openDatabase(
    join(await getDatabasesPath(), 'PlayerDB.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute('''CREATE TABLE Player(
        name TEXT,
        jerNo INTEGER PRIMARY KEY,
        runs INT,
        avg REAL)''');
    },
  );

  // Insert into

  Player batsman1 =
      Player(name: "Virat Kohli", jerNo: 18, runs: 54300, avg: 58.70);

  insertPlayerData(batsman1);

  // We have created an object of the Player class to insert it into the database.

  Player batsman2 =
      Player(name: "Rohit Sharma", jerNo: 45, runs: 45236, avg: 50.52);

  insertPlayerData(batsman2);

  Player batsman3 = Player(name: "KL Rahul", jerNo: 1, runs: 36052, avg: 48.23);

  await insertPlayerData(batsman3);
}
