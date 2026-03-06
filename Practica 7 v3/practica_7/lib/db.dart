import 'package:sqlite/alumno.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {

  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(),'alumnos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alumnos (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, matricula TEXT, carrera TEXT, semestre TEXT, modalidad TEXT, curso TEXT, beca TEXT)",
        );
      },
      version: 1
    );
  }

  // INSERT
  static Future<int> insert(Alumno alumno) async {
    Database database = await _openDB();
    return database.insert("alumnos", alumno.toMap());
  }

 


  // SELECT
  static Future<List<Alumno>> alumnos() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> alumnosMap =
        await database.query("alumnos");

    return List.generate(
      alumnosMap.length,
      (i) => Alumno(
        id: alumnosMap[i]['id'],
        nombre: alumnosMap[i]['nombre'],
        matricula: alumnosMap[i]['matricula'],
        carrera: alumnosMap[i]['carrera'],
        semestre: alumnosMap[i]['semestre'],
        modalidad: alumnosMap[i]['modalidad'],
        curso: alumnosMap[i]['curso'],
        beca: alumnosMap[i]['beca'],
      ),
    );
  }
}