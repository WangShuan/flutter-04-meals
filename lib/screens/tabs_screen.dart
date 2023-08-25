import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './filters_screen.dart';
import './meals_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _activeIndex = 0;

  void selectedScreen(String routeName) async {
    Navigator.of(context).pop();
    if (routeName == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FutureBuilder(
            future: ref.watch(filterMealsProvider),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return MealsScreen('所有食譜', snapshot.data!);
              } else {
                return const Center(
                  child: Text('no meals.'),
                );
              }
            }),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoMeals = ref.watch(favoriteMealsProvider);

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
      body: _activeIndex == 0
          ? FutureBuilder(
              future: ref.watch(filterMealsProvider),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return CategoriesScreen(snapshot.data!);
                } else {
                  return const Center(
                    child: Text('no meals.'),
                  );
                }
              })
          : MealsScreen('', favoMeals),
    );
  }
}
