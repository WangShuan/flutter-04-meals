import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

import '../data/dummy_categories.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';
import './meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(this.meals, this.toggleFavo, {super.key});
  final List<Meal> meals;
  final void Function(Meal meal) toggleFavo;

  void _selectedCategory(BuildContext context, Category category) {
    final List<Meal> mealsByCategory = meals.where((m) => m.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(category.title, mealsByCategory, toggleFavo),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.75,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final c in categories)
          CategoryGridItem(
            c.title,
            c.color,
            () => _selectedCategory(context, c),
          )
      ],
    );
  }
}
