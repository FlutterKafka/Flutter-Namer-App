import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/theme/theme.dart';
import 'package:english_words/english_words.dart';
import 'package:namer_app/widgets/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: lightMode,
        darkTheme: darkMode,
        home: const Navigation(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];
  late Future<Database> database;

  MyAppState() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _initDatabase();
    await _loadFavorites();
  }
  
  Future<void> _initDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'wordpair_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(first TEXT, second TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _loadFavorites() async {
    favorites = await _getFavorites();
    notifyListeners();
  }

  Future<void> getNext() async {
    current = WordPair.random();
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final db = await database;
    if (favorites.contains(current)) {
      favorites.remove(current);
      await db.delete(
        'favorites',
        where: 'first = ? AND second = ?',
        whereArgs: [current.first, current.second],
      );
    } else {
      favorites.add(current);
      await db.insert(
        'favorites',
        {'first': current.first, 'second': current.second},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    notifyListeners();
  }

  Future<void> removeFavorite(WordPair pair) async {
    final db = await database;
    favorites.remove(pair);
    await db.delete(
      'favorites',
      where: 'first = ? AND second = ?',
      whereArgs: [pair.first, pair.second],
    );
    notifyListeners();
  }

  Future<List<WordPair>> _getFavorites() async {
    final db = await database;
    final List<Map<String, Object?>> favoriteMaps = await db.query('favorites');
    return [
      for (final {'first': first as String, 'second': second as String} in favoriteMaps)
        WordPair(first, second),
    ];
  }
}