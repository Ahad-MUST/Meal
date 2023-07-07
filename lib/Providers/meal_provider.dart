import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_meals.dart';

final mealsprovider = Provider(
  (ref) => dummyMeals,
);
