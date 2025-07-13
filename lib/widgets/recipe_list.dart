import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../screens/detail_screen.dart';
import '../widgets/recipe_card.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return InkWell(
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
                MaterialPageRoute(builder: (_) => DetailScreen(recipe: recipe)),
              );
            }
          },
          child: RecipeCard(recipe: recipe),
        );
      },
    );
  }
}
