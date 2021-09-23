import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager/src/models/task.dart';

const String dbName = 'tasks';
const String tableName = 'Tasks';

class TaskDB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (Database db, int version) {
        return db.execute("""
            CREATE TABLE Tasks ( 
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              type TEXT,
              complianceDate TEXT,
              responsable TEXT,
              author TEXT,
              project TEXT,
              state TEXT,
              users TEXT
            ) """);
      },
      version: 1,
    );
  }

  static Future<bool> insert(Task task) async {
    try {
      Database db = await _openDB();
      await db.insert(tableName, task.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> update(Task task) async {
    try {
      Database db = await _openDB();
      await db.update(tableName, task.toJson(),
          where: 'id = ?', whereArgs: [task.id]);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> delete(Task task) async {
    try {
      Database db = await _openDB();
      await db.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Task>> getTasks() async {
    Database db = await _openDB();
    List<Map<String, dynamic>> species = await db.query(tableName);
    return List.generate(
        species.length, (index) => Task.fromJson(species[index]));
  }
}
