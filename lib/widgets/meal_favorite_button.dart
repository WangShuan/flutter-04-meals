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
    final isFavo = favoriteMeals.contains(widget.meal);
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
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isFavo ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavo),
        ),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: Tween(begin: 1.25, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn)),
            child: child,
          );
        },
      ),
    );
  }
}
