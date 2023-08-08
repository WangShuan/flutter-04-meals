import 'package:flutter_riverpod/flutter_riverpod.dart';

import './meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) {
    return FiltersNotifier();
  },
);

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final Map<Filter, bool> selectedFilter = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (!meal.isGlutenFree && selectedFilter[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && selectedFilter[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegan && selectedFilter[Filter.vegan]!) {
      return false;
    }
    if (!meal.isVegetarian && selectedFilter[Filter.vegetarian]!) {
      return false;
    }
    return true;
  }).toList();
});
