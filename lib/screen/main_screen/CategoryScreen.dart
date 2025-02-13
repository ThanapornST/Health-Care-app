import 'package:appfinal/data/dummy_category.dart';
import 'package:appfinal/screen/sub_screen/BeverageMenu.dart';
import 'package:appfinal/screen/sub_screen/DessertMenu.dart';
import 'package:appfinal/screen/sub_screen/FruitMenu.dart';
import 'package:appfinal/screen/sub_screen/MainManu.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  void _selectCategory(BuildContext context, String categoryId) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    if (categoryId == 'c1') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainManuScreen()),
      );
    } else if (categoryId == 'c2') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FruitManuScreen()),
      );
    } else if (categoryId == 'c3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DessertMenuScreen()),
      );
    } else if (categoryId == 'c4') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BeverageMenuScreen()),
      );
    }
  }

  List<bool> _selectedMeals = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Calories'),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
      ),
      body: ListView.builder(
        itemCount: dummyMeals.length,
        itemBuilder: (ctx, index) {
          final meal = dummyMeals[index];
          return InkWell(
            onTap: () {
              _selectCategory(context, meal.categories.first);
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          meal.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                          width: 300,
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Text(
                            meal.title,
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
