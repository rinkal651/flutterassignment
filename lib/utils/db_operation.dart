import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/movie.dart';

class DbOperation {
  static final DbOperation _instance = DbOperation._();
  static Database? _database;

  DbOperation._();

  factory DbOperation() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'movies.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies(
        id INTEGER PRIMARY KEY,
        title TEXT,
        posterPath TEXT,
        releaseDate TEXT,
        voteAverage REAL,
        voteCount INTEGER,
        genreIds TEXT
      )
    ''');
  }

  // Insert a movie into the database
  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    return await db.insert(
      'movies',
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete a movie from the database
  Future<int> removeMovie({required int movieId}) async {
    final db = await database;
    List<Object?> whereArg = [];
    whereArg.add(movieId);
    return await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: whereArg
    );
  }

  // Get all movies from the database
  Future<List<Movie>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');

    return List.generate(maps.length, (i) {
      return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        posterPath: maps[i]['posterPath'],
        releaseDate: maps[i]['releaseDate'],
        voteAverage: maps[i]['voteAverage'],
        voteCount: maps[i]['voteCount'],
        genreIds: List<int>.from(maps[i]['genreIds']),
      );
    });
  }

  // Clear all data from the database
  Future<void> clearMovies() async {
    final db = await database;
    await db.delete('movies');
  }
}
