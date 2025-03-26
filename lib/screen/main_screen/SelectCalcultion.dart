import 'dart:math';
import 'package:appfinal/screen/main_screen/CalculatePage.dart';
import 'package:appfinal/screen/main_screen/CategoryScreen.dart';
import 'package:appfinal/screen/main_screen/health%20advice.dart';
import 'package:appfinal/screen/sub_screen/ExercisePage.dart';
import 'package:appfinal/screen/main_screen/SummarizePage.dart';
import 'package:appfinal/screen/main_screen/Table_Calendar.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:appfinal/widget/button/button_page.dart';
import 'package:flutter/material.dart';
import 'package:appfinal/services/firestore_service.dart';
import 'package:appfinal/services/gemini_service.dart';

class SelectCalculation extends StatefulWidget {
  final String? name;
  final String? imageUrl;
  final String? logoUrl;
  final String height;
  final String weight;

  const SelectCalculation({
    this.name,
    this.imageUrl,
    this.logoUrl,
    required this.height,
    required this.weight,
    super.key,
  });

  @override
  State<SelectCalculation> createState() => _SelectCalculationState();
}

class _SelectCalculationState extends State<SelectCalculation> {
  int _totalCalories = 0;
  int _burnedCalories = 0;

  List<Map<String, String>> _consumedItems = [];
  List<Map<String, String>> _burnedItems = [];

  final FirestoreService _firestoreService = FirestoreService();

  void _addCalories(String title, String calorie) {
    setState(() {
      int cal = int.parse(calorie);
      _totalCalories += cal;
      _consumedItems.add({"title": title, "calorie": "$cal kcal"});
    });
  }

  void _updateBurnedCalories(String title, String burned) {
    setState(() {
      int cal = int.parse(burned);
      _burnedCalories += cal;
      _burnedItems.add({"title": title, "calorie": "$cal kcal"});
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showHealthPopup(context);
    });
  }

// ✅ ฟังก์ชันสำหรับคำนวณโปรตีน คาร์โบไฮเดรต และเวลาออกกำลังกาย ตามน้ำหนักและเป้าหมาย
  Map<String, dynamic> getHealthRecommendation(double weight, String goal) {
    double protein = 0.0;
    double carb = 0.0;
    int exerciseMinutes = 0;

    if (goal == "ลดน้ำหนัก") {
      protein = weight * 1.8;
      carb = weight * 3.5;
      exerciseMinutes = 40;
    } else if (goal == "เพิ่มกล้ามเนื้อ") {
      protein = weight * 2.0;
      carb = weight * 5;
      exerciseMinutes = 30;
    } else {
      protein = weight * 1.5;
      carb = weight * 4;
      exerciseMinutes = 30;
    }

    return {
      "protein": protein.round(),
      "carb": carb.round(),
      "exercise": exerciseMinutes
    };
  }

// ✅ ฟังก์ชันแบ่งมื้ออาหาร
  Map<String, Map<String, int>> splitMeals(double protein, double carb) {
    return {
      "มื้อเช้า": {
        "protein": (protein * 0.3).round(),
        "carb": (carb * 0.3).round(),
      },
      "มื้อกลางวัน": {
        "protein": (protein * 0.4).round(),
        "carb": (carb * 0.4).round(),
      },
      "มื้อเย็น": {
        "protein": (protein * 0.3).round(),
        "carb": (carb * 0.3).round(),
      },
    };
  }

// ✅ ฟังก์ชัน popup แนะนำสุขภาพ + BMI + AI โดยใช้ค่าที่ส่งมา
  void _showHealthPopup(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      double height = double.parse(widget.height);
      double weight = double.parse(widget.weight);
      double heightInMeters = height / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      String uuid = await _firestoreService.getOrCreateUserUUID();
      var userDoc = await _firestoreService.getUserData(uuid);
      final userData = userDoc.data() as Map<String, dynamic>; // ✅ แก้ตรงนี้

      // ✅ ตรวจสอบค่า null และกำหนดค่า default
      int age = userData['age'] is int ? userData['age'] : 25;
      String gender =
          userData['gender'] is String ? userData['gender'] : 'male';
      String goal = "ลดน้ำหนัก"; // หรือให้ผู้ใช้เลือกภายหลัง

      // ✅ เรียก AI
      String aiAdvice = await GeminiService.getHealthAdvice(
        age,
        gender,
        weight,
        height,
        goal,
      );

      // ✅ คำนวณค่าต่างๆ
      final recommendation = getHealthRecommendation(weight, goal);
      final mealPlans = splitMeals(
        recommendation['protein'].toDouble(),
        recommendation['carb'].toDouble(),
      );

      Navigator.pop(context); // ปิด loading

      // ✅ แสดง Popup
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            '🎯 แนะนำสุขภาพวันนี้',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('📏 BMI:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text(bmi.toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: bmi >= 18.5 && bmi <= 24.9
                              ? Colors.green
                              : Colors.orange)),
                ],
              ),
              const Divider(height: 20, thickness: 1),
              _buildAdviceRow(
                  "🏋️‍♀️ ออกกำลังกาย", "${recommendation['exercise']} นาที"),
              _buildAdviceRow(
                  "🍗 โปรตีนรวม", "${recommendation['protein']} กรัม"),
              _buildAdviceRow(
                  "🍚 คาร์โบไฮเดรตรวม", "${recommendation['carb']} กรัม"),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ตกลง')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HealthAdviceScreen(
                      age: age,
                      gender: gender,
                      weight: weight,
                      height: height,
                      goal: goal,
                      recommendation: recommendation,
                      splitMeals: mealPlans,
                    ),
                  ),
                );
              },
              child: const Text('ดูเพิ่มเติม'),
            ),
          ],
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      print("❌ Error in _showHealthPopup: $e");
    }
  }

  // ---------------------------------------------------

  Widget _buildAdviceRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.430,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Image.network(
                              widget.imageUrl ??
                                  'https://i.pinimg.com/736x/6c/04/f4/6c04f47686c8e86bb4da000ffeceb330.jpg',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error, size: 60),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Height: ${widget.height} cm',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text('Weight: ${widget.weight} kg',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    'Date: ${DateTime.now().toString().split(' ')[0]}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(19.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                    border: Border.all(color: AppColors.secondary, width: 1.0),
                  ),
                  child: Column(
                    children: getAllHealthTips()
                        .map((tip) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(tip,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]))))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ButtonPage())),
        ],
      ),
    );
  }

  List<String> getAllHealthTips() => [
        "🥗 กินผักผลไม้",
        "🚶‍♂️ ออกกำลังกาย",
        "💧 ดื่มน้ำ",
        "😴 พักผ่อน",
        "🌞 แสงแดด",
        "🧘‍♀️ สมาธิ",
        "🍎 อาหารไม่แปรรูป"
      ];
}
