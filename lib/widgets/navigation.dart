import 'package:flutter/material.dart';
import 'package:namer_app/pages/favorites.dart';
import 'package:namer_app/pages/homepage.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<Navigation> {
  var selectedIndex = 0;
  List<Widget> pages = [const Homepage(), const FavoritesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? NavigationBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedIndex: selectedIndex,
              onDestinationSelected: ((value) {
                setState(() {
                  selectedIndex = value;
                });
              }),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home), 
                  label: 'Home'
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites'
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 600)
            NavigationRail(
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedIndex: selectedIndex,
              onDestinationSelected: ((value) {
                setState(() {
                  selectedIndex = value;
                });
              }),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
            ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
