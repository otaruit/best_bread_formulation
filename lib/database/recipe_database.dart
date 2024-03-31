import 'package:best_bread_formulation/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecipeDatabase {
  static const int _version = 1;
  static const String _dbName = "Recipe.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Recipe(
          recipeId TEXT PRIMARY KEY,
          latestVersion REAL NOT NULL,
          uid TEXT NOT NULL,
          imageLinks TEXT NOT NULL,
          recipeName TEXT NOT NULL
        )
        )
      ''');
      },
      version: _version, // _version の定義を確認してください
    );
  }

  static Future<int> addRecipe(Recipe recipe) async {
    final db = await _getDB();
    return await db.insert("Recipe", recipe.toJson() as Map<String, Object?>,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateRecipe(Recipe recipe) async {
    final db = await _getDB();
    return await db.update("Recipe", recipe.toJson() as Map<String, Object?>,
        where: 'recipeId = ?',
        whereArgs: [recipe.recipeId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteRecipe(Recipe recipe) async {
    final db = await _getDB();
    return await db
        .delete("Recipe", where: 'recipeId = ?', whereArgs: [recipe.recipeId]);
  }

  static Future<List<Recipe>?> getAllRecipe() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Recipe");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Recipe.fromJson(maps[index] as String));
  }
}
