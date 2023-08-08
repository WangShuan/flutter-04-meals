import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('篩選器')),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('不含麩質', style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text('篩選所有不含麩質的食譜', style: Theme.of(context).textTheme.bodyMedium),
            activeColor: Theme.of(context).colorScheme.primary,
            value: selectedFilter[Filter.glutenFree]!,
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, value);
            },
          ),
          SwitchListTile(
            title: Text('不含乳糖', style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text('篩選所有不含乳糖的食譜', style: Theme.of(context).textTheme.bodyMedium),
            activeColor: Theme.of(context).colorScheme.primary,
            value: selectedFilter[Filter.lactoseFree]!,
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, value);
            },
          ),
          SwitchListTile(
            title: Text('全素可食用', style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text('篩選所有全素可食用的食譜', style: Theme.of(context).textTheme.bodyMedium),
            activeColor: Theme.of(context).colorScheme.primary,
            value: selectedFilter[Filter.vegan]!,
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, value);
            },
          ),
          SwitchListTile(
            title: Text('蛋奶素可食用', style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text('篩選所有蛋奶素可食用的食譜', style: Theme.of(context).textTheme.bodyMedium),
            activeColor: Theme.of(context).colorScheme.primary,
            value: selectedFilter[Filter.vegetarian]!,
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, value);
            },
          ),
        ],
      ),
    );
  }
}
