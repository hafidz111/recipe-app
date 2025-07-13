import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/widgets/recipe_grid.dart';
import 'package:recipeapp/widgets/recipe_list.dart';

import '../providers/recipe_provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final bookmarks = provider.bookmarks;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 600;

        return Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Bookmarked Recipes',
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You can revisit your saved recipes here.',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: bookmarks.isEmpty
                    ? const Center(
                        child: Text(
                          'No bookmarks yet',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : constraints.maxWidth <= 600
                    ? RecipeList(recipes: bookmarks)
                    : constraints.maxWidth <= 1200
                    ? RecipeGrid(recipes: bookmarks, gridCount: 4)
                    : RecipeGrid(recipes: bookmarks, gridCount: 6),
              ),
            ],
          ),
        );
      },
    );
  }
}
