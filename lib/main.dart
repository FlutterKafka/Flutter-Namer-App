import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/theme/theme.dart';
import 'package:english_words/english_words.dart';
import 'package:namer_app/widgets/navigation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordPairAdapter());
  await Hive.openBox("db");
  runApp(const MyApp());
}

class WordPairAdapter extends TypeAdapter<WordPair> {
  @override
  final int typeId = 0;

  @override
  WordPair read(BinaryReader reader) {
    final first = reader.readString();
    final second = reader.readString();
    return WordPair(first, second);
  }

  @override
  void write(BinaryWriter writer, WordPair obj) {
    writer.writeString(obj.first);
    writer.writeString(obj.second);
  }
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
  final db = Hive.box("db");

  MyAppState() {
    favorites = List<WordPair>.from(db.get("db") ?? []);
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    db.put("db", favorites);
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    db.put("db", favorites);
    notifyListeners();
  }
}
