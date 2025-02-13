import 'package:appfinal/screen/main_screen/DailyActivityCard%20.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  // ค่าแคลอรี
  int caloriesConsumed = 2000;  // จำนวนแคลที่กิน
  int caloriesBurned = 500;     // จำนวนแคลที่เผาผลาญ
  int remainingCalories = 0;    // ค่าคำนวณ (แคลที่เหลือ)

  // ฟังก์ชันคำนวณแคลอรี
  void _calculateRemainingCalories() {
    setState(() {
      remainingCalories = caloriesConsumed - caloriesBurned;
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateRemainingCalories(); // คำนวณค่าเมื่อเริ่มต้น
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ใช้สีพื้นหลัง
      appBar: AppBar(
        title: const Text("Calculate"),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Today Target
            DailyActivityCard(
              caloriesConsumed: caloriesConsumed,
              caloriesBurned: caloriesBurned,
              remainingCalories: remainingCalories,
              sleepTime: "23:00",
            ),
            const SizedBox(height: 20),

            // Activity Status
            const Text(
              "Activity Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Today Target Card
            _buildTodayTarget(),
          ],
        ),
      ),
    );
  }

  // Today Target
  Widget _buildTodayTarget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Today Target",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          
          ElevatedButton(
            onPressed: () {
              _calculateRemainingCalories(); // คำนวณแคลใหม่เมื่อกดปุ่ม
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("Check"),
          ),
        ],
      ),
    );
  }
}
