import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/recipe_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
