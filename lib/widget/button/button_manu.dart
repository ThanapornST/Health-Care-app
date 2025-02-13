import 'package:appfinal/screen/main_screen/CategoryScreen.dart';
import 'package:appfinal/screen/main_screen/ExercisePage.dart';
import 'package:appfinal/screen/main_screen/SelectCalcultion.dart';
import 'package:appfinal/screen/main_screen/SummarizePage.dart';
import 'package:appfinal/screen/main_screen/Table_Calendar.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CalculateFoodCalories extends StatefulWidget {
  final String height;
  final String weight;

  const CalculateFoodCalories({
    required this.height,
    required this.weight,
    super.key,
  });

  @override
  State<CalculateFoodCalories> createState() => _CalculateFoodCaloriesState();
}

class _CalculateFoodCaloriesState extends State<CalculateFoodCalories> {
  int _page = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      SelectCalcultion(
        height: widget.height,
        weight: widget.weight,
      ),
      const CategoryScreen(),
      const SummarizePage(),
      const TableCalendarScreen(),
      const ExerciseScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppColors.primary, // ใช้สีหลักเป็นสีปุ่ม
        color: AppColors.secondary, // ใช้สีรองเป็นสีพื้นหลังแถบ
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 26, color: AppColors.iconColor),
          Icon(Icons.fastfood, size: 26, color: AppColors.iconColor),
          Icon(Icons.favorite, size: 26, color: AppColors.iconColor),
          Icon(Icons.calendar_month_outlined,
              size: 26, color: AppColors.iconColor),
          Icon(Icons.directions_run, size: 26, color: AppColors.iconColor),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
