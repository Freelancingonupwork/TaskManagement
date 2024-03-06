import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:task_management/features/tasks/data/model.dart';

class DbHelper {
  static const int _version = 1;
  static const String _dbName = 'tasks.db';

  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  DbHelper._internal();

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_dbName';

    final database = await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            completed INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
    return database;
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final maps = await db.query('Tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<dynamic> saveTask(Task task) async {
    final db = await database;
    return await db.insert('Tasks', task.toMap());
  }

  Future<dynamic> deleteTask(int taskId) async {
    final db = await database;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [taskId]);
  }
}
