import 'package:flutter/material.dart';
import 'package:namer_app/widgets/cards.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class Landscape extends StatelessWidget {
  const Landscape({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        body: GridView.builder(
          gridDelegate: 
            const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              mainAxisExtent: 80,
            ),
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