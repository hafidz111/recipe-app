import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/detail_content.dart';

class WebDetail extends StatelessWidget {
  final Recipe recipe;
  const WebDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Image.network(
            recipe.image,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: DetailContent(recipe: recipe),
          ),
        ),
      ],
    );
  }
}
