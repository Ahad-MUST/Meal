import 'package:flutter/material.dart';
import 'package:meals/Providers/favorites_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Providers/filters_provider.dart';

const kinitialfilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return const FiltersScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = ref.watch(availablemealsprovider);
    ;
    Widget activeScreen = CategoriesScreen(
      availablemeals: availablemeals,
    );

    var activeScreenTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoritemeals = ref.watch(favoriteprovider);
      activeScreen = MealsScreen(
        meals: favoritemeals,
      );
      activeScreenTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(onSelectScreen: setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
