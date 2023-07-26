import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.categoryItem, required this.onSelectedCategory});

  final Category categoryItem;

  final  void Function() onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // esiste anche gesture detector che offre ampie funzionalità sui tocchi, con il inKwell si ottiene anche un feedback vusuvo
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              categoryItem.color.withOpacity(0.55),
              categoryItem.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          categoryItem.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
