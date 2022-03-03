import 'package:crud_sqlite/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static const _databaseName = 'contactsdata.db';
  static const _databaseVersion = 1;
  
  static final DatabaseHelper instance = DatabaseHelper._db();  
  static Database? _database; 
  DatabaseHelper._db();

  Future<Database> get database async{
    if(_database != null) {return _database!;}
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async{    
    final dbPath = await getApplicationDocumentsDirectory();   
    final path = join(dbPath.path,_databaseName);

    return await openDatabase( 
      path, 
      version: _databaseVersion,
      onCreate: (db, version) async{
        return await db.execute('''
          CREATE TABLE IF NOT EXISTS ${Contact.tblContact} (
            ${Contact.colId} INTEGER PRIMARY KEY, 
            ${Contact.colName} TEXT NOT NULL,
            ${Contact.colPhoneNumber} TEXT NOT NULL)
          ''');
      },
    );    
  }   

  Future<int> put(Contact? contact) async{
    Database? db = await database;
    if(contact?.id == null){
      int i = await db.insert(Contact.tblContact, contact!.toMap());
      print(i);
      return i;
    }else{
      return await db.update(Contact.tblContact, contact!.toMap(),
      where: '${Contact.colId} = ?', whereArgs: [contact.id]);
    }
  }

  Future<int> deleteContact(int id) async{
    Database? db = await database;
    return db.delete(Contact.tblContact, where: '${Contact.colId} = ?', whereArgs: [id]);
  }

  Future<List<Contact>> fetchContacts() async{
    Database? db = await database;
    List<Map<String, dynamic>> contacts = await db.query(Contact.tblContact);

    return contacts.isEmpty
    ? []
    :contacts.map((e) => Contact.fromMap(e)).toList();
  }  
}