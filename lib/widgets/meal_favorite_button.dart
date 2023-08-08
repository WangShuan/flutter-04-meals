import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';

class MealFavoriteButton extends ConsumerStatefulWidget {
  const MealFavoriteButton(this.meal, {super.key});
  final Meal meal;

  @override
  ConsumerState<MealFavoriteButton> createState() => _MealFavoriteButtonState();
}

class _MealFavoriteButtonState extends ConsumerState<MealFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    return IconButton(
      onPressed: () {
        final isAddFavo = ref.read(favoriteMealsProvider.notifier).toggleFavo(widget.meal);

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isAddFavo ? '已將食譜${widget.meal.title}添加到喜好項目。' : '已將食譜${widget.meal.title}從喜好項目中移除。'),
          ),
        );
      },
      icon: Icon(favoriteMeals.contains(widget.meal) ? Icons.favorite : Icons.favorite_border),
    );
  }
}
