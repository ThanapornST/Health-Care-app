import 'package:appfinal/screen/sub_screen/BeverageMenu.dart';
import 'package:appfinal/screen/sub_screen/DessertMenu.dart';
import 'package:appfinal/screen/sub_screen/FruitMenu.dart';
import 'package:appfinal/screen/sub_screen/MainManu.dart';
import 'package:appfinal/screen/sub_screen/Sleepingpage.dart';
import 'package:appfinal/screen/sub_screen/ExercisePage.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:appfinal/widget/DailyActivityCard%20.dart';
import 'package:appfinal/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  int caloriesConsumed = 0;
  int caloriesBurned = 0;
  int remainingCalories = 0;
  double bmr = 0.0;
  String sleepTime = "--";
  bool _showSummary = false; // สำหรับแสดงสรุปผล

  double weight = 70;
  double height = 170;
  int age = 25;
  String gender = "male";

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchCaloriesData();
  }

  Future<void> _fetchUserData() async {
    String uuid = await _firestoreService.getOrCreateUserUUID();
    DocumentSnapshot userDoc = await _firestoreService.getUserData(uuid);

    if (userDoc.exists) {
      setState(() {
        age = userDoc['age'] ?? age;
        gender = userDoc['gender'] ?? gender;
        height = (userDoc['height'] ?? height).toDouble();
        weight = (userDoc['weight'] ?? weight).toDouble();
      });

      _calculateBMR();
    }
  }

  Future<void> _fetchCaloriesData() async {
    String uuid = await _firestoreService.getOrCreateUserUUID();
    int totalConsumed = await _firestoreService.getTotalCaloriesConsumed(uuid);
    int totalBurned = await _firestoreService.getTotalCaloriesBurned(uuid);

    setState(() {
      caloriesConsumed = totalConsumed;
      caloriesBurned = totalBurned;
      _calculateRemainingCalories();
    });
  }

  void _calculateBMR() async {
    setState(() {
      if (gender == "male") {
        bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
      } else {
        bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
      }
    });

    await _firestoreService.saveUserBMRAndRemainingCalories(bmr, remainingCalories);
    print("✅ คำนวณ BMR สำเร็จ: $bmr kcal/day");
  }

  void _calculateRemainingCalories() async {
    setState(() {
      remainingCalories = bmr.round() - (caloriesConsumed - caloriesBurned);
    });

    await _firestoreService.saveUserBMRAndRemainingCalories(bmr, remainingCalories);
    print("✅ คำนวณ Remaining Calories สำเร็จ: $remainingCalories kcal");
  }

  void addCalories(String title, String calorie, int count) {
    int calorieValue = int.tryParse(calorie.replaceAll(' kcal', '')) ?? 0;
    int totalCalories = calorieValue * count;

    setState(() {
      caloriesConsumed += totalCalories;
      _calculateRemainingCalories();
    });

    print("✅ เพิ่มเมนู: $title - $totalCalories kcal ($count ครั้ง)");
  }

  Future<void> _showUpdateDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeverageMenuScreen(
                      onSelectMenu: (title, calorie, count) {
                        addCalories(title, calorie, count);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: const Text("Update Beverage Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DessertMenuScreen(
                      onSelectMenu: (title, calorie, count) {
                        addCalories(title, calorie, count);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: const Text("Update Dessert Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FruitMenuScreen(
                      onSelectMenu: (title, calorie, count) {
                        addCalories(title, calorie, count);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: const Text("Update Fruit Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainMenuScreen(
                      onSelectMenu: (title, calorie, count) {
                        addCalories(title, calorie, count);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: const Text("Update Main Menu Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                final String? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SleepingPage()),
                );
                if (result != null) {
                  setState(() {
                    sleepTime = result;
                  });
                }
              },
              child: const Text("Update Sleep Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseScreen(
                      onSelectMenu: (title, calorie, count) {
                        addCalories(title, calorie, count);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: const Text("Update Exercise Data"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับแสดงข้อมูลสรุป
  Widget _buildSummaryCard() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(top: 10),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "📊 ข้อมูลสรุปสุขภาพ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildSummaryRow("🍽️ รับประทาน", "$caloriesConsumed kcal"),
                _buildSummaryRow("🔥 เผาผลาญ", "$caloriesBurned kcal"),
                _buildSummaryRow("💪 BMR", "${bmr.toStringAsFixed(2)} kcal/day"),
                _buildSummaryRow(
                  "⚖️ แคลอรี่ที่เหลือ",
                  "$remainingCalories kcal",
                  color: remainingCalories < 0 ? Colors.red : Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Calculate"),
        backgroundColor: AppColors.secondary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            DailyActivityCard(
              caloriesConsumed: caloriesConsumed,
              caloriesBurned: caloriesBurned,
              remainingCalories: remainingCalories,
              sleepTime: sleepTime,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showUpdateDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text("Update Data"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showSummary = !_showSummary;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(_showSummary ? "ซ่อนสรุปผล" : "ดูสรุปผล"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "BMR: ${bmr.toStringAsFixed(2)} kcal/day",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_showSummary) _buildSummaryCard(),
          ],
        ),
      ),
    );
  }
}
