import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';
import 'package:meals/screens/meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MealDetailsScreen(meal: meal);
    }));
  }

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      if (meals.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title!),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No meals found for this category.',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  "try another category.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(title!),
          ),
          body: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                meal: meals[index],
                onselectMeal: selectMeal,
              );
            },
            itemCount: meals.length,
          ),
        );
      }
    } else {
      if (meals.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No meals found for this category.',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                "try another category.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: meals[index],
              onselectMeal: selectMeal,
            );
          },
          itemCount: meals.length,
        );
      }
    }
  }
}
