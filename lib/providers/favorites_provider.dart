import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);
  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);
    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>(
  (ref) {
    return FavoritesMealsNotifier();
  },
);
