import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static late var database;

  Future<Database> getDB() async {
    //variavel de inicialização do banco
    database = openDatabase(join(await getDatabasesPath(), 'dbcurso.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE contact(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)",
      );
    }, version: 1);
    return database;
  }
}
