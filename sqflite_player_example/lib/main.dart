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

  Map<String, dynamic> playerMap() {
    return {
      'name': name,
      'jerNo': jerNo,
      'runs': runs,
      'avg': avg,
    };
  }

  @override
  String toString() {
    return '{name:$name, jerNo:$jerNo,runs:$runs, avg:$avg}';
  }
}

Future insertPlayerData(Player obj) async {
  // assign the database to the local variable localDB

  final localDB = await database;

  // The insert method from the database class is used to insert the data in the player table.

  // The insert method takes 3 parameters i.e TABLE NAME, MAP OF DATA TO BE PASSED, CONFLICT ALGORITHM.

  //The CONFLICT ALGORITHM is applied when data with same PRIMARY KEY is inserted.

  await localDB.insert(
    "Player",
    obj.playerMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Player>> getPlayerData() async {
  final localDB = await database;

  // The Query method from the database class returns a list of map which contains all the data present in the table Player.

  List<Map<String, dynamic>> listPlayers = await localDB.query("Player");

  // here we will convert the list of Map returned from the query method into the list of objects of Players.

  return List.generate(listPlayers.length, (i) {
    return Player(
      name: listPlayers[i]['name'],
      jerNo: listPlayers[i]['jerNo'],
      runs: listPlayers[i]['runs'],
      avg: listPlayers[i]['avg'],
    );
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

  print(await getPlayerData());
}
