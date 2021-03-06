// ignore_for_file: avoid_print

import 'package:calender_app/models/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();

  static Database? _db;
  static const int _version = 1;
  static const String _tabelName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = join(await getDatabasesPath() + 'tasks.db');
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('creating a new one');
          return db.execute(
            "CREATE TABLE $_tabelName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<int> insert(TaskModel task) async {
    // Database db = await initDb();
    debugPrint('insert function called');
    return await _db?.insert(_tabelName, task.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint('query function called');
    return await _db?.query(_tabelName) ?? [];
  }

  static delete(TaskModel task) async {
    debugPrint('delete function called');
    return await _db?.delete(_tabelName, where: 'id=?', whereArgs: [task.id]) ??
        1;
  }

  static update(int id) async {
    debugPrint('updated table');
    return await _db?.rawUpdate('''
UPDATE tasks 
SET isCompleted = ?
  WHERE id = ?
''', [1, id]);
  }
}
