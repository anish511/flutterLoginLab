import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final _databasename = "person.db";
  static final _databaseversion = 1;

  static final table = "my_table";

  static final columnID = 'id';
  static final columnName = "name";
  static final columnage = "age";

  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database?> get database async {
    if(_database != Null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, _databasename);
    return await openDatabase(path, version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version) async {
    await db.execute(

      'CREATE TABLE $table ( $columnID INTEGER PRIMARY KEY autoincrement, $columnName TEXT NOT NULL,$columnage INTEGER NOT NULL)'

    );
  }

  // CRUD
  Future<dynamic> insert(Map<String,dynamic> row) async {
    Database? db = await instance.database;
    //int? id1 = await db?.rawInsert(
    //    'INSERT INTO Test(columnName,columnage) VALUES("some name", 14)');
    //print('inserted1: $id1');
    return await db?.insert(table,row);
  }

  Future<List<Map <String,dynamic>>?> queryAll() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  Future<List<Map <String,dynamic>>?> query(int age) async {
    Database? db = await instance.database;
    //var res = await db?.query(table, where: "age > ?",whereArgs: [age]);
    var res = await db?.rawQuery("SELECT * FROM my_table WHERE age > ?",[age]);
    return res;
  }

  Future<int?> delete(int age) async {
    Database? db = await instance.database;
    var res = await db?.delete(table, where: "age > ?",whereArgs: [age]);
    return res;
  }

  Future<int?> update(int id) async {
    Database? db = await instance.database;
    var res = await db?.update(table,{"name":"Desi","age":2},where: "age > ?",whereArgs: [id]);
    return res;
  }
}