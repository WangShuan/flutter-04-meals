import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen(this.meal, this.toggleFavo, {super.key});
  static String routerName = 'meal';

  final Meal meal;
  final void Function(Meal meal) toggleFavo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () => toggleFavo(meal),
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Hero(
                    tag: meal.id,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: meal.imgUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.schedule),
                          const SizedBox(width: 8),
                          Text(meal.duration, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('材料', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final item in meal.ingredients)
                      Text(
                        meal.ingredients.last == item ? item : '$item、',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('製作方式', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              for (final (index, step) in meal.steps.indexed)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(step, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
