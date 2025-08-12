import 'package:namer_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/widgets/cards.dart';
import 'package:namer_app/responsive/responsive.dart';
import 'package:namer_app/responsive/portrait.dart';
import 'package:namer_app/responsive/landscape.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    if (context.watch<MyAppState>().favorites.isEmpty) {
      return const Center(child: SmallCard());
    }

    return const Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      body: ResponsiveLayout(
        portrait: Portrait(), 
        landscape: Landscape(),
      ),
    );
  }
}