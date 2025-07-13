import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/providers/recipe_provider.dart';
import 'package:recipeapp/widgets/detail_content.dart';

class MobileDetail extends StatefulWidget {
  final Recipe recipe;
  const MobileDetail({super.key, required this.recipe});

  @override
  State<MobileDetail> createState() => _MobileDetailState();
}

class _MobileDetailState extends State<MobileDetail> {
  final _sheetController = DraggableScrollableController();
  double _sheetSize = 0.65;

  @override
  void initState() {
    super.initState();
    _sheetController.addListener(() {
      setState(() {
        _sheetSize = _sheetController.size;
      });
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final double imageMaxHeight = 300;
    final double imageMinHeight = 100;
    final double imageHeight = (imageMaxHeight - (_sheetSize - 0.65) * 400)
        .clamp(imageMinHeight, imageMaxHeight);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Image.network(
                widget.recipe.image,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  provider.isBookmarked(widget.recipe)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: Colors.green,
                ),
                onPressed: () => provider.toggleBookmark(widget.recipe),
              ),
            ),
          ),

          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.65,
            minChildSize: 0.4,
            maxChildSize: 0.8,
            expand: true,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    DetailContent(recipe: widget.recipe, showBookmark: false),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
