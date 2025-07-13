import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _bookmarks = [];
  List<Recipe> get bookmarks => _bookmarks;

  void toggleBookmark(Recipe recipe) {
    if (_bookmarks.any((r) => r.id == recipe.id)) {
      _bookmarks.removeWhere((r) => r.id == recipe.id);
    } else {
      _bookmarks.add(recipe);
    }
    notifyListeners();
  }

  bool isBookmarked(Recipe recipe) {
    return _bookmarks.any((r) => r.id == recipe.id);
  }
}
