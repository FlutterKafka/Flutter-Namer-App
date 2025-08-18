import 'package:namer_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});
  final WordPair pair;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class SmallCard extends StatelessWidget {
  const SmallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'No favorites yet',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}

class TileCard extends StatelessWidget {
  const TileCard({super.key, required this.pair});
  final WordPair pair;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context).colorScheme;

    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: ElevatedButton(
          onPressed: () {
            appState.removeFavorite(pair);
          },
          child: Icon(Icons.favorite, color: theme.tertiary),
        ),
        title: Text(pair.asLowerCase, textAlign: TextAlign.start),
      ),
    );
  }
}
