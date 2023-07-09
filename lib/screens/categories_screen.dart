import 'package:flutter/material.dart';
import 'package:meals/data/dummy_categories.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_item.dart';
import 'package:meals/models/Category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availablemeals});
  final List<Meal> availablemeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationcontroller;

  @override
  void initState() {
    super.initState();
    _animationcontroller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 700),
    );
    _animationcontroller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationcontroller.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredmeals = widget.availablemeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredmeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationcontroller,
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.10, 0.25),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationcontroller, curve: Curves.easeInOut),
        ),
        child: child,
      ),
      child: GridView(
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
