import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:record/sql_model/dog.dart';
import 'package:sqflite/sqflite.dart';

class My extends StatefulWidget {
  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  late Future<Database> database;
  var dataStr = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _openDb,
          child: Text('打开数据库'),
        ),
        ElevatedButton(
          onPressed: _add,
          child: Text('插入dogs数据'),
        ),
        ElevatedButton(
          onPressed: _query,
          child: Text('查看dogs数据'),
        ),
        Center(child: Text(dataStr)),
      ],
    );
  }

  void _openDb() async {
    // final directory = await getApplicationDocumentsDirectory();
    // final path = join(directory.path, 'doggie_database.db');
    database = openDatabase(
        join(await getDatabasesPath(), 'doggie_database.db'),
        version: 1, onCreate: (db, version) {
      return db.execute('create table dogs('
          'id integer primary key,'
          'name text,'
          'age integer,'
          ')');
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(path)),
    // );
  }

  void _query() async {
    final db = await database;
    const pageSize = 10;
    const page = 2;
    final List<Map<String, Object?>> dogMaps = await db.query('dogs',
      columns: ['id'],
      // limit: pageSize,
      // offset: pageSize * (page - 1),
    );
    // print(dogMaps.toString());
    setState(() {
      dataStr = dogMaps.toString();
    });
  }

  void _add() async {
    final db = await database;

    var fido = Dog(
      id: Random().nextInt(1000) + 1,
      name: 'Fido',
      age: 35,
    );

    print(fido.id);
    await db.insert(
      'dogs',
      fido.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
