import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static const _databaseName = 'ContactData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Database get database{
    if(_database != null) return _database;
    _database = _initDataBase();
    return _database;
  }

  _initDatabase() async{
    var dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory, _databaseName);
  }
}