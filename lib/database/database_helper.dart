import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/categoria.dart';
import '../models/producto.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tienda.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE productos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        categoriaId INTEGER NOT NULL,
        FOREIGN KEY (categoriaId) REFERENCES categorias (id)
      )
    ''');
  }

  // Métodos CRUD para Categorías
  Future<int> insertCategoria(Categoria categoria) async {
    final db = await database;
    return await db.insert('categorias', categoria.toMap());
  }

  Future<List<Categoria>> getCategorias() async {
    final db = await database;
    final result = await db.query('categorias');
    return result.map((map) => Categoria.fromMap(map)).toList();
  }

  // Métodos CRUD para Productos
  Future<int> insertProducto(Producto producto) async {
    final db = await database;
    return await db.insert('productos', producto.toMap());
  }

  Future<List<Producto>> getProductosByCategoria(int categoriaId) async {
    final db = await database;
    final result = await db.query(
      'productos',
      where: 'categoriaId = ?',
      whereArgs: [categoriaId],
    );
    return result.map((map) => Producto.fromMap(map)).toList();
  }
}
