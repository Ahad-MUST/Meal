import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Providers/meal_provider.dart';
import 'package:meals/models/meal_model.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FiltersProviderNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersProviderNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isactive) {
    state = {
      ...state,
      filter: isactive,
    };
  }
}

final filtersprovider =
    StateNotifierProvider<FiltersProviderNotifier, Map<Filter, bool>>(
        (ref) => FiltersProviderNotifier());

final availablemealsprovider = Provider((ref) {
  final meals = ref.watch(mealsprovider);
  final activefilters = ref.watch(filtersprovider);
  return meals.where((meal) {
    if (activefilters[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilters[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activefilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
