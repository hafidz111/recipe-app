import 'package:flutter/material.dart';

class RecipeSearch extends StatelessWidget {
  final SearchController controller;
  final void Function(String) onSearch;
  final void Function()? onClear;

  const RecipeSearch({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SearchAnchor(
              searchController: controller,
              builder: (context, searchController) {
                return SearchBar(
                  controller: searchController,
                  hintText: 'Search recipe',
                  leading: const Icon(Icons.search),
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      onSearch(value.trim());
                    }
                  },
                  onChanged: (value) {
                    if (value.trim().isEmpty && onClear != null) {
                      onClear!();
                    }
                  },
                );
              },
              suggestionsBuilder: (context, controller) {
                return List<ListTile>.generate(3, (int index) {
                  final item = 'Suggestion $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      controller.closeView(item);
                      onSearch(item);
                    },
                  );
                });
              },
            ),
          ),
        );
      },
    );
  }
}
