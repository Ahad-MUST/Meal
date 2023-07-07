import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_model.dart';

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);
  bool togglefavoritestatus(Meal meal) {
    final mealisfavorite = state.contains(meal);
    if (mealisfavorite) {
      state = state.where((element) => element != meal).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteprovider = StateNotifierProvider<FavoriteNotifier, List<Meal>>(
    (ref) => FavoriteNotifier());
