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
  runApp(const MainApp());

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
