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
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
