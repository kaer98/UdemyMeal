import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import "package:meals/widgets/category_grid_item.dart";
import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animantionController;

  @override
  void initState() {
    super.initState();
    _animantionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
    _animantionController.forward();
  }

  @override
  void dispose() {
    _animantionController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MealsScreen(
              title: category.title.toString(),
              meals: filteredMeals,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animantionController,
        child: GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (Category category in availableCategories)
              CategoryGridItem(
                  category: category,
                  onselectCategory: () => _selectedCategory(context, category)),
          ],
        ),
        builder: (context, child) {
          return SlideTransition(
            position: Tween(
              begin: Offset(0, 0.3),
              end: Offset(0, 0),
            ).animate(
              CurvedAnimation(
                  parent: _animantionController, curve: Curves.easeInOut),
            ),
            child: child,
          );
        });
  }
}
//197