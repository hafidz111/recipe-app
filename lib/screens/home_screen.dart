import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/recipe_grid.dart';
import 'package:recipeapp/widgets/recipe_list.dart';
import 'package:recipeapp/widgets/recipe_search.dart';

import '../models/recipe.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SearchController _searchController;
  late Future<List<Recipe>> _futureRecipes;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    _futureRecipes = ApiService().fetchRecipes();
  }

  void _search(String query) {
    setState(() {
      _futureRecipes = ApiService().searchRecipes(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.local_dining,
                            size: 32,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'What do you want to cook today?',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                    ? 22
                                    : 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RecipeSearch(
                        controller: _searchController,
                        onSearch: _search,
                        onClear: () {
                          setState(() {
                            _futureRecipes = ApiService().fetchRecipes();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    FutureBuilder<List<Recipe>>(
                      future: _futureRecipes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: s${snapshot.error}"),
                          );
                        }

                        final recipes = snapshot.data ?? [];

                        if (recipes.isEmpty) {
                          return const Center(child: Text('No recipes found'));
                        }

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth <= 600
                                ? RecipeList(recipes: recipes)
                                : RecipeGrid(recipes: recipes, gridCount: 4);
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
