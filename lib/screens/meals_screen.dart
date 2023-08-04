import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';
import './meal_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(this.title, this.meals, this.toggleFavo, {super.key});

  final String title;
  final List<Meal> meals;
  final void Function(Meal meal) toggleFavo;

  void _selectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealScreen(meal, toggleFavo),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return title.isEmpty
        ? meals.isNotEmpty
            ? GridView(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  for (final m in meals)
                    MealItem(m, () {
                      _selectedMeal(context, m);
                    })
                ],
              )
            : Center(
                child: Text(
                  '這個類別沒有任何食譜，您可以嘗試更改篩選器。',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
        : Scaffold(
            appBar: AppBar(title: Text(title)),
            body: meals.isNotEmpty
                ? GridView(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    children: [
                      for (final m in meals)
                        MealItem(m, () {
                          _selectedMeal(context, m);
                        })
                    ],
                  )
                : Center(
                    child: Text(
                      '這個類別沒有任何食譜，您可以嘗試更改篩選器。',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
          );
  }
}
