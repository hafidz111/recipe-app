import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/mobile_detail.dart';
import '../widgets/web_detail.dart';

class DetailScreen extends StatefulWidget {
  final Recipe recipe;
  const DetailScreen({super.key, required this.recipe});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isMobile = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width;
    setState(() {
      isMobile = width <= 600;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobile ? null : AppBar(title: Text(widget.recipe.title)),
      body: isMobile
          ? MobileDetail(recipe: widget.recipe)
          : WebDetail(recipe: widget.recipe),
    );
  }
}
