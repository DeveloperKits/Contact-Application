import 'package:contact_application/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  final _createTable = """create table contacts(
    $colId integer primary key,
    $colName text,
    $colMobile text,
    $colEmail text,
    $colAddress text,
    $colFavorite integer)""";

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = path.join(root, "contacts.db");
    return openDatabase(
        dbPath,
        version: 2,
        onCreate: (db, version) {
          db.execute(_createTable);
        },

      onUpgrade: (db, oldVersion, newVersion) {
          if(oldVersion == 1 && newVersion == 2){
            const sql = "alter table $tblContact add column $colImage text default ''";
            db.execute(sql);
          }
      }
    );
  }

  Future<int> insertContact(ContactModel contact) async {
    final db = await _open();
    return db.insert(tblContact, contact.toMap());
  }
  
  Future<int> updateSingleContactValue(int id, Map<String, dynamic> map) async {
    final db = await _open();
    return db.update(tblContact, map, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deleteSingleContact(int id) async{
    final db = await _open();
    return db.delete(tblContact, where: '$colId = ?', whereArgs: [id]);
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await _open();
    final mapList = await db.query(tblContact);
    return List.generate(mapList.length, (index) {
      return ContactModel.fromMap(mapList[index]);
    });
  }

  Future<List<ContactModel>> getFavoriteContacts() async {
    final db = await _open();
    final mapList = await db.query(tblContact, where: '$colFavorite = ?', whereArgs: [1]);
    return List.generate(mapList.length, (index) {
      return ContactModel.fromMap(mapList[index]);
    });
  }

  Future<ContactModel> getContactsById(int id) async {
    final db = await _open();
    final mapList = await db.query(tblContact, where: '$colId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }
}
