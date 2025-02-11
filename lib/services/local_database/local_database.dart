import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._singleton();

  static final _constructor = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _constructor;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = "$databasePath/mydatabase.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullname TEXT NOT NULL,
        year_of_study INTEGER NOT NULL,
        mark INTEGER NOT NULL,
        groupId INTEGER NOT NULL
      )
''');

    await db.execute('''
      CREATE TABLE groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
      )
''');
  }
}
