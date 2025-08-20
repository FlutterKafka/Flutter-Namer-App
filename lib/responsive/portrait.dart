import 'package:flutter/material.dart';
import 'package:namer_app/widgets/cards.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class Portrait extends StatelessWidget {
  const Portrait({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView.builder(
          itemCount: appState.favorites.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TileCard(pair: appState.favorites[index])
            );
          },
        ),
      ),
    );
  }
}
