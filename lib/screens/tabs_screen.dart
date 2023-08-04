import 'package:flutter/material.dart';

import '../data/dummy_categories.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';
import './categories_screen.dart';
import './filters_screen.dart';
import './meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _activeIndex = 0;

  Map<Filter, bool> _selectedFilter = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  final List<Meal> _favoMeals = [];
  void toggleFavo(Meal meal) {
    if (_favoMeals.contains(meal)) {
      setState(() {
        _favoMeals.remove(meal);
      });
      _showMessage('已將食譜${meal.title}從喜好項目中移除。');
    } else {
      setState(() {
        _favoMeals.add(meal);
      });
      _showMessage('已將食譜${meal.title}添加到喜好項目中。');
    }
  }

  void selectedScreen(String routeName) async {
    Navigator.of(context).pop();
    if (routeName == 'filters') {
      final filters = (await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(_selectedFilter),
        ),
      ))!;

      setState(() {
        _selectedFilter = filters;
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen('所有食譜', meals, toggleFavo),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> filterMeals = meals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilter[Filter.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilter[Filter.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilter[Filter.vegan]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilter[Filter.vegetarian]!) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_activeIndex == 0 ? '所有類別' : '喜好項目'),
      ),
      drawer: MainDrawer(selectedScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category_rounded), label: '所有類別'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '喜好項目'),
        ],
        currentIndex: _activeIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
      body: _activeIndex == 0 ? CategoriesScreen(filterMeals, toggleFavo) : MealsScreen('', _favoMeals, toggleFavo),
    );
  }
}
