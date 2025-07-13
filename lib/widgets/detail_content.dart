import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/providers/recipe_provider.dart';

class DetailContent extends StatelessWidget {
  final Recipe recipe;
  final bool showBookmark;
  const DetailContent({
    super.key,
    required this.recipe,
    this.showBookmark = true,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final isBookmarked = provider.isBookmarked(recipe);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (showBookmark)
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.green,
                ),
                onPressed: () => provider.toggleBookmark(recipe),
              ),
          ],
        ),
        const SizedBox(height: 16),

        const Text(
          'Ingredients',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F6F6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recipe.ingredients
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('• $item'),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Steps',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        Column(
          children: recipe.steps.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final step = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green),
                          color: index == 1 ? Colors.green : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '$index',
                            style: TextStyle(
                              color: index == 1 ? Colors.white : Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      if (index != recipe.steps.length)
                        Container(width: 2, height: 40, color: Colors.green),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(step),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
