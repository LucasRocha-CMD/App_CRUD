import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '/models/planets.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Inicializa a fábrica de banco de dados FFI se não estiver em dispositivos móveis
    if (!Platform.isAndroid && !Platform.isIOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "planets.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Planets(
        id INTEGER PRIMARY KEY,
        nome TEXT,
        tamanho REAL,
        distancia REAL,
        apelido TEXT
      )
    ''');
  }

  // Métodos CRUD
  Future<int> insertPlanet(Planets planet) async {
    Database db = await instance.database;
    return await db.insert('Planets', planet.toMap());
  }

  Future<List<Planets>> getAllPlanets() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('Planets');
    return List.generate(maps.length, (i) {
      return Planets.fromMap(maps[i]);
    });
  }

  Future<int> updatePlanet(Planets planet) async {
    Database db = await instance.database;
    return await db.update('Planets', planet.toMap(),
        where: 'id = ?', whereArgs: [planet.id]);
  }

  Future<int> deletePlanet(int id) async {
    Database db = await instance.database;
    return await db.delete('Planets', where: 'id = ?', whereArgs: [id]);
  }

  static DatabaseHelper get instance => _instance;

  Future<Planets?> getPlanet(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'Planets',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Planets.fromMap(result.first);
    } else {
      return null;
    }
  }
}
