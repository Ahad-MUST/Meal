import 'package:meals/models/Category_model.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.selectedcategory});
  final Category category;
  final void Function() selectedcategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectedcategory();
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(.55),
              category.color.withOpacity(.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
