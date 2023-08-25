import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';
import './meals_screen.dart';

final _supabase = supabase.Supabase.instance.client;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(this.meals, {super.key});
  final List<Meal> meals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final List<Meal> mealsByCategory = widget.meals.where((m) => m.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(category.title, mealsByCategory),
    ));
  }

  final _stream = _supabase.from('categories').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: StreamBuilder(
        stream: _stream,
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
                  for (final c in snapshot.data!)
                    CategoryGridItem(
                      c['title'],
                      Color(c['color']),
                      () => _selectedCategory(context, Category(c['id'], c['title'], Color(c['color']))),
                    )
                ],
              );
            }
          }
        },
      ),
      // builder: (context, child) {
      //   return Opacity(
      //     opacity: _animationController.value,
      //     child: child,
      //   );
      // },
      builder: (context, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack),
          child: child,
        );
      },
    );
  }
}
