import 'package:flutter/material.dart';
import 'package:meals/data/dummy_meals.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/drawer.dart';

const kinitialfilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  Map<Filter, bool> _selectedfilters = kinitialfilters;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Center(child: Text(message))));
  }

  final List<Meal> favoriteMeals = [];
  void CheckFavoriteMeals(Meal meal) {
    setState(() {
      if (favoriteMeals.contains(meal)) {
        favoriteMeals.remove(meal);
        _showMessage('Meal is no longer favorite');
      } else {
        favoriteMeals.add(meal);
        _showMessage('Meal added to favorite');
      }
    });
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return FiltersScreen(
              currentfilters: _selectedfilters,
            );
          },
        ),
      );
      setState(() {
        _selectedfilters = result ?? kinitialfilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = dummyMeals.where((meal) {
      if (_selectedfilters[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedfilters[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedfilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedfilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      OnToggleFavorite: CheckFavoriteMeals,
      availablemeals: availablemeals,
    );

    var activeScreenTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        OnToggleFavorite: CheckFavoriteMeals,
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
