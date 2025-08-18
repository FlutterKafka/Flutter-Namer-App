import 'package:flutter/material.dart';
import 'package:namer_app/widgets/cards.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BigCard(pair: appState.current),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLikeButton(appState, theme),
                const SizedBox(width: 8.0),
                _buildNextButton(appState, theme),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton(MyAppState appState, ThemeData theme) {
    final isFavorite = appState.favorites.contains(appState.current);

    return ElevatedButton.icon( 
      onPressed: appState.toggleFavorite,
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: theme.colorScheme.tertiary,
      ),
      label: Text('Like', style: theme.textTheme.labelLarge),
    );
  }

  Widget _buildNextButton(MyAppState appState, ThemeData theme) {
    return ElevatedButton(
      onPressed: appState.getNext,
      child: Text('Next', style: theme.textTheme.labelLarge),
    );
  }
}