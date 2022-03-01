import 'package:crud_sqlite/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static const _databaseName = 'contactsData.db';
  static const _databaseVersion = 1;
  
  static final DatabaseHelper instance = DatabaseHelper._db();
  DatabaseHelper._db();
  static Database? _database; 

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDatabase(_databaseName);
    return _database!;
  }

  _initDatabase(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);
    return await openDatabase( 
      path, 
      version: _databaseVersion,
      onCreate:(db, version) async{
        db.execute('''
          CREATE TABLE ${Contact.tblContact}(
            ${Contact.colId} INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT, 
            ${Contact.colName} TEXT NOT NULL,
            ${Contact.colPhoneNumber} TEXT NOT NULL)
          ''');
      });
  }

  Future<int> put(Contact? contact) async{
    Database? db = await database;
    return db.insert(Contact.tblContact, contact!.toMap());
  }

  Future<List<Contact>> fetchContacts() async{
    Database? db = await database;
    List<Map<String, dynamic>> contacts = await db.query(Contact.tblContact);

    return contacts.length == 0 
    ? []
    :contacts.map((e) => Contact.fromMap(e)).toList();
  }  
}