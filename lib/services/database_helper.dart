import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:aplicacion_3479a321lab3/entity/activity.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    await database;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activity_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //Creación de la base de datos
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE actividad (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fecha TEXT NOT NULL,
        nombre TEXT NOT NULL
      )
    ''');
  }

  // Inserta una nueva actividad
  Future<void> insertActivity(Activity activity) async {
    final db = await database;
    await db.insert(
      'actividad', //Nombre de la tabla
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera todas las actividades
  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('actividad');

    return List.generate(maps.length, (i) {
      return Activity.fromMap(maps[i]);
    });
  }

    Future<void> updateActivity(Activity activity) async {
    final db = await database;
    await db.update(
      'actividad',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  Future<void> deleteActivity(int id) async {
    final db = await database;
    await db.delete(
      'actividad',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
