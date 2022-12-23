import 'package:grocery_app/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
//SINGLETON

  //static instance to use
  static DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //for initializing instace of this class
  DatabaseHelper._privateConstructor();

//DATABASE

  //reference variable of database...
  static Database? _database;

  //initialize or get database from file
  Future<Database> initializeDatabase() async {
    String dbpath = await getDatabasesPath();
    dbpath = dbpath + "/g_app.db";
    var database = await openDatabase(dbpath, version: 1, onCreate: _createdb);
    return database;
  }

  //if initializing then create table for database
  void _createdb(Database db, int newversion) {
    // creations of tables
    String query = '''create table user
                    (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      email TEXT,
                      gender TEXT,
                      city TEXT,
                      password TEXT,
                      img TEXT
                       ) 
                    ''';
    db.execute(query);
    print('table created..');
  }

//for initializing instace of this class
  Future<Database> get database async {
    // if(_database==null)
    //     _database=await initializeDatabase();
    _database ??= await initializeDatabase();

    return _database!;
  }


  Future<dynamic> login(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query("user",
        where: "email=? and password=?", whereArgs: [email, password]);

  
    if(data!=null){
      print(data.length);
      if(data.length>0)
       return  User.fromMap(data[0]);
     
    }
    print(data.length);
    return false;
    //whether the object is null or not, if null incorrect fields :else: login with its object
  }

   Future<bool> Sigup(User obj)async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query("user",
        where: "email=?", whereArgs: [obj.email]);

    if (data.isEmpty) {
      await db.insert("user", obj.toMap());
      return true;
    }
    return false;
   
  }
}
