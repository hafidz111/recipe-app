import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../screens/detail_screen.dart';
import '../widgets/recipe_card_grid.dart';

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final int gridCount;

  const RecipeGrid({super.key, required this.recipes, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: gridCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 4 / 3,
        children: recipes.map((recipe) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(recipe: recipe)),
              );
            },
            child: RecipeCardGrid(
              recipe: recipe,
              onTap: () {
                final isMobile = MediaQuery.of(context).size.width <= 600;

                if (isMobile) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => DetailScreen(recipe: recipe),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(recipe: recipe),
                    ),
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
