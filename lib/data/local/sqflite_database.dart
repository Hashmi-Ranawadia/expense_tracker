import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabase {
  static final SqfliteDatabase _instance = SqfliteDatabase._();
  static Database? _database;

  SqfliteDatabase._();

  factory SqfliteDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'expense_tracker.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY, category TEXT, amount REAL, date TEXT, description TEXT)',
        );
      },
    );
  }
}
