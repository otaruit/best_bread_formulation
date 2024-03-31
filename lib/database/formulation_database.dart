import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:best_bread_formulation/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FormulationDatabase {
  static const int _version = 1;
  static const String _dbName = "Formulation.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Formulation(
          id TEXT PRIMARY KEY,
          version REAL NOT NULL,
          creationDate INTEGER NOT NULL,
          strongFlour INTEGER NOT NULL,
          weakFlour INTEGER NOT NULL,
          butter INTEGER NOT NULL,
          sugar INTEGER NOT NULL,
          salt INTEGER NOT NULL,
          skimMilk INTEGER NOT NULL,
          east INTEGER NOT NULL,
          water INTEGER NOT NULL,
          recipeId TEXT NOT NULL
        )
      ''');
      },
      version: _version, // _version の定義を確認してください
    );
  }

  static Future<int> addFormulation(Formulation formulation) async {
    final db = await _getDB();
    return await db.insert(
        "Formulation", formulation.toJson() as Map<String, Object?>,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateFormulation(Formulation formulation) async {
    final db = await _getDB();
    return await db.update(
        "Formulation", formulation.toJson() as Map<String, Object?>,
        where: 'id = ?',
        whereArgs: [formulation.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteFormulation(Formulation formulation) async {
    final db = await _getDB();
    return await db
        .delete("Formulation", where: 'id = ?', whereArgs: [formulation.id]);
  }

  static Future<List<Note>?> getAllFormulation() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Formulation");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Note.fromJson(maps[index] as String));
  }
}
