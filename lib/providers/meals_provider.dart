import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final _supabase = supabase.Supabase.instance.client;

final mealsProvider = Provider((ref) async {
  final List data = await _supabase.from('meals').select();
  final List<Meal> m = [];
  try {
    for (final e in data) {
      final List categoriesData = json.decode(e['categories']);
      final List ingredientsData = json.decode(e['ingredients']);
      final List stepsData = json.decode(e['steps']);

      m.add(Meal(
        id: e['id'],
        title: e['title'],
        categories: categoriesData.map((c) => '$c').toList(),
        imgUrl: e['imgUrl'],
        ingredients: ingredientsData.map((i) => '$i').toList(),
        steps: stepsData.map((s) => '$s').toList(),
        duration: e['duration'],
        isGlutenFree: e['isGlutenFree'],
        isLactoseFree: e['isLactoseFree'],
        isVegan: e['isVegan'],
        isVegetarian: e['isVegetarian'],
      ));
    }
  } catch (e) {
    print('error:$e');
  }
  return m;
});
