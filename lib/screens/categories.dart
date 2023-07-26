import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.avaibleMeals});

  final List<Meal> avaibleMeals;


  void _selectedCategory(BuildContext context, Category category) {
    // stimo usando un metodo in statless perchè non vogliamo aggiornare lo stato!!!!
    final filteredMeals = avaibleMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20, // si allarga , e diventa più corto
          mainAxisSpacing:
              20, // Il valore di childAspectRatio rappresenta il rapporto tra larghezza e altezza.
        ), // diventa più lingo
        children: [
          // for(final category in availableCategories)
          //   CategoryGridItem(categoryItem: category),

          ...availableCategories
              .map((category) => CategoryGridItem(
                    categoryItem: category,
                    onSelectedCategory: () {
                      _selectedCategory(context, category);
                    },
                  ))
              .toList(),
        ],
      );
  }
}
