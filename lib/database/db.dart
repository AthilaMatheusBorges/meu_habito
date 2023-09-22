import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  // Construtor com acesso privado
  DB._();
  // Criar uma instancia de DB
  static final DB instance = DB._();
  //Instancia do SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'meuhabito.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_tarefas);
    await db.execute(_dias);
    // await db.execute(_historico);
    // await db.insert('conta', {'saldo': 0});
  }

  String get _tarefas => '''
    CREATE TABLE tarefas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      horario TIME,
      icone TEXT,
      notificacao TEXT,
      frequencia TEXT,
    );
  ''';

  String get _dias => '''
    CREATE TABLE dias (
      data DATE PRIMARY KEY,
    );
  ''';
  
}