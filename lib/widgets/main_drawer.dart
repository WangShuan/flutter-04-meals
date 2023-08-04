import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer(this.selectedScreen, {super.key});
  final void Function(String routeName) selectedScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: DrawerHeader(
              margin: const EdgeInsets.all(0),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
              child: Row(
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Meals",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        letterSpacing: 2),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              '所有食譜',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            onTap: () {
              selectedScreen('meals');
            },
          ),
          ListTile(
            title: Text(
              '篩選器',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            onTap: () {
              selectedScreen('filters');
            },
          )
        ],
      ),
    );
  }
}
