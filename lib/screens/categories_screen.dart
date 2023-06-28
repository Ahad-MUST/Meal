import 'package:flutter/material.dart';
import 'package:meals/data/dummy_categories.dart';
import 'package:meals/data/dummy_meals.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_item.dart';
import 'package:meals/models/Category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  void _selectCategory(BuildContext context, Category category) {
    final filteredmeals = dummyMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: category.title, meals: filteredmeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              selectedcategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}