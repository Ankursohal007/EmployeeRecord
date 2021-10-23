import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databasename ="persons.db";
  static final _databaseversion = 1;
  static final table ="my_table";
  static final columnID ="EmpCode";
  static final columnName ="EmpName";
  static final columnAddress ="EmpAddress";
  static final columnMobile ="EmpMobile";
  static final columnDOB ="EmpAge";
  static final columnRemark ="EmpRemark";
  static Database? _database;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  Future<Database> get database async{
    if(_database != null) {
      return _database!;
    }
    _database =await _initDatabase();
    return _database!;
  }
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =join(documentsDirectory.path, _databasename);

    return await openDatabase(path, version: _databaseversion, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE $table(
    $columnID TEXT PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnAddress TEXT NOT NULL,
    $columnMobile TEXT NOT NULL,
    $columnDOB TEXT NOT NULL,
    $columnRemark TEXT NOT NULL
    )    
    ''');
  }
  // Cursor c=dbhelper.rawQuery("SELECT * FROM user WHERE user="EmpCode", null);
  //     if(c.moveToFirst())
  // {
  // showMessage("Error", "Record exist");
  // }
  // else
  // {
  // // Inserting record
  // }

  Future<bool> checkData(String columnID) async{
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT * FROM my_table WHERE EmpCode=?' ,[columnID]);

    if(res.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> insertData(Map<String, dynamic> row) async {
   Database db = await instance.database;
   return await db.insert(table, row);
  }
  Future<List<Map<String, dynamic>>> queryAllRow()async{
    Database db = await instance.database;
    return await db.query(table);
  }
  Future<List<Map<String, dynamic>>> querySpecific(int age)async{
    Database db = await instance.database;
    //var res = await db.query(table, where: "age<= ?" , whereArgs: [age]);
    var res = await db.rawQuery('SELECT * FROM my_table WHERE age <= ?',[age]);
    return res;
  }
  Future deleteData(List<Object?>? id)async{
    Database db = await instance.database;
    var res = await db.delete(table, where: '$columnID IN (${id!.join(',')})');
    return res;
  }
  Future update(Map<String, dynamic> row,String  id)async{
    Database db = await instance.database;
    var res = await db.update(table, row, where: "$columnID=?" ,whereArgs: [id]);
    return res;
  }
  Future deleteAllData()async{
    Database db = await instance.database;
    var res = await db.delete(table);
    return res;
  }
}
