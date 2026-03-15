import 'package:sqlite/dispositivo.dart'; 
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dispositivos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dispositivos (id INTEGER PRIMARY KEY AUTOINCREMENT, cliente TEXT, tipo TEXT, marca TEXT, modelo TEXT, serie TEXT UNIQUE, falla TEXT, fecha TEXT)",
        );
      },
      version: 1
    );
  }

  
  static Future<int> insert(Dispositivo dispositivo) async {
    Database database = await _openDB();
    return database.insert("dispositivos", dispositivo.toMap());
  }

  // buscar
  static Future<List<Dispositivo>> dispositivos() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> dispositivosMap = await database.query("dispositivos");

    return List.generate(
      dispositivosMap.length,
      (i) => Dispositivo(
        id: dispositivosMap[i]['id'],
        cliente: dispositivosMap[i]['cliente'],
        tipo: dispositivosMap[i]['tipo'],
        marca: dispositivosMap[i]['marca'],
        modelo: dispositivosMap[i]['modelo'],
        serie: dispositivosMap[i]['serie'],
        falla: dispositivosMap[i]['falla'],
        fecha: dispositivosMap[i]['fecha'],
      ),
    );
  }

  // modificasr
  static Future<int> update(Dispositivo dispositivo) async {
    Database database = await _openDB();
    return database.update(
      "dispositivos", 
      dispositivo.toMap(), 
      where: "id = ?", 
      whereArgs: [dispositivo.id]
    );
  }

  // para eliminiar por el id
  static Future<int> delete(int id) async {
    Database database = await _openDB();
    return database.delete("dispositivos", where: "id = ?", whereArgs: [id]);
  }

  // para validad si ya ha un dispositivo con ese numoero de serie
  static Future<bool> checkSerieExists(String serie, {int? currentId}) async {
    Database database = await _openDB();
    List<Map> result;
    if (currentId != null) {
      // si se actualiza0 se ignorar el propio ID del dispositivo actual
      result = await database.query("dispositivos", where: "serie = ? AND id != ?", whereArgs: [serie, currentId]);
    } else {
      result = await database.query("dispositivos", where: "serie = ?", whereArgs: [serie]);
    }
    return result.isNotEmpty;
  }
}