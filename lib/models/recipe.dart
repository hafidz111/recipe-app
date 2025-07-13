class Recipe {
  final String id;
  final String title;
  final String image;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
      ingredients: List.generate(20, (i) {
        final ing = json['strIngredient${i + 1}'];
        final meas = json['strMeasure${i + 1}'];
        if (ing != null && ing.toString().trim().isNotEmpty) {
          return '$meas $ing'.trim();
        }
        return null;
      }).whereType<String>().toList(),
      steps: (json['strInstructions'] as String)
          .split('.')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }
}
