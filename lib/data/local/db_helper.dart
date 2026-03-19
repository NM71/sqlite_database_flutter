import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // table variables
  static final String TABLE_NOTE = 'notes';
  static final String COLUMN_NOTE_SNO = 's_no';
  static final String COLUMN_NOTE_TITLE = 'title';
  static final String COLUMN_NOTE_DESC = 'description';

  /// singleton
  DBHelper._(); // This makes the constructor private, which means it can't be called, which means no object creation.
  // So no multiple instances then....

  // ---------------------------------------------------------------------
  // static DBHelper getInstance() {
  //   return DBHelper._();

  /// We can also do it like this:
  static final DBHelper getInstance = DBHelper._();
  // ---------------------------------------------------------------------

  Database? myDB;
  // Open DB (checks path => if exists then open, if not then creates one)
  Future<Database> getDB() async {
    // we need to check if a db already exists

    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }

    // a better way
    // myDB = myDB ?? await openDB(); // This is same as above
    // return myDB!;

    // Orrrrr..
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    // we will define 2 logics for both opening a db and creating a db
    Directory appDir = await getApplicationDocumentsDirectory();

    // join method to create our custom path
    // join(path1, "filename")
    String dbPath = join(
      appDir.path,
      "noteDB.db",
    ); // ".db" is an extension for an sqlite file

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        // creating all the tables
        db.execute(
          "create table $TABLE_NOTE($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text) ",
        );

        // we can create 'n' number of tables like this, just one thing that all tables should have a unique name
        // because in that case the previously created table gets overridden by the new one
      },
      version: 1,
    );
  }

  // All Queries (CRUD Operations)

  // Insertion => CREATE (set)
  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    // Now here we need our database as it is an independent function, so we call getDB() and openDB() in here
    var db = await getDB();

    int rowsEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mTitle,
      COLUMN_NOTE_DESC: mDesc,
    });

    return rowsEffected > 0;
  }

  // Select => READ (fetch)
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
    return mData;
  }

  // UPDATE (edit)
  Future<bool> updateNote({
    required int sno,
    required String title,
    required String desc,
  }) async {
    var db = await getDB();

    int rowsEffected = await db.update(
      TABLE_NOTE,
      {COLUMN_NOTE_TITLE: title, COLUMN_NOTE_DESC: desc},
      where: "$COLUMN_NOTE_SNO = $sno",
    ); // only update values where serial no matches the note we are editing

    return rowsEffected > 0;
  }

  // DELETE (remove)
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();

    int rowsEffected = await db.delete(
      TABLE_NOTE,
      where: "$COLUMN_NOTE_SNO = ?",
      whereArgs: ['$sno'],
    );
    return rowsEffected > 0;
  }

  // }
}
