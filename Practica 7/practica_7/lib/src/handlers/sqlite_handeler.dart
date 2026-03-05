import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class SqliteHandler{


  Future<Database> getDb() async {


    String databasepath = await getDatabasesPath();


    String path = join(databasepath,'mydatabase.db');

     



    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

  }
  

  //Funcion para crear la base de datos si no existe

  void _onCreate(Database db, int version) async {

    await db.execute('''CREATE TABLE registros 
    (idx INTEGER PRIMARY KEY, nombre TEXT,
     matricula INTEGER, 
     carrera TEXT,
     semestre TEXT,
     modalidad TEXT
     curso TEXT
     );

    ''' );


  }

}