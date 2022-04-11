import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/joke.dart';

class JokesStorage {
  final String tableJoke = 'jokes';
  final String dbName = 'jokes.db';

  static JokesStorage? _instance;
  JokesStorage._() {}

  Database? db;

  factory JokesStorage() {
    _instance ??= JokesStorage._();
    return _instance!;
  }

  bool get isInitialized => db != null;

  Future<void> initDb() async {
    print("Db initialisation ...");
    db = await openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE $tableJoke(id INTEGER PRIMARY KEY, joke TEXT, category TEXT, safe INTEGER, favorite INTEGER)');
    }, version: 1);
  }

  Future<bool> update(Joke joke) async {
    return await db!.update(tableJoke, joke.toSqlite()) > 0;
  }

  Future<int> insert(Joke joke) async {
    print("Joke to save: $joke");
    return await db!.insert(tableJoke, joke.toSqlite(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> remove(Joke joke) async {
    return await db!.delete(tableJoke,
        where: 'id = ? and favorite = ?', whereArgs: [joke.id, 1]);
  }

  Future<Joke> getJoke(int id) async {
    final joke = await db!.query(tableJoke, where: 'id=?', whereArgs: [id]);
    return Joke.fromSqlite(joke.first);
  }

  Future<List<Joke>> getJokes() async {
    final data =
        await db!.query(tableJoke, where: 'favorite = ?', whereArgs: [1]);
    print("Data found: $data");
    return data.map((e) => Joke.fromSqlite(e)).toList();
  }
}
