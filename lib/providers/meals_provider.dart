import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dummy_categories.dart';

final mealsProvider = Provider((ref) {
  return meals;
});
