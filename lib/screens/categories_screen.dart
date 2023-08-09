import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';
import './meals_screen.dart';

final _supabase = supabase.Supabase.instance.client;

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(this.meals, {super.key});
  final List<Meal> meals;

  void _selectedCategory(BuildContext context, Category category) {
    final List<Meal> mealsByCategory = meals.where((m) => m.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(category.title, mealsByCategory),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _supabase.from('categories').select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('Something wrong...'),
              );
            } else {
              return GridView(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  for (final c in snapshot.data)
                    CategoryGridItem(
                      c['title'],
                      Color(c['color']),
                      () => _selectedCategory(context, Category(c['id'], c['title'], Color(c['color']))),
                    )
                ],
              );
            }
          }
        });
  }
}
