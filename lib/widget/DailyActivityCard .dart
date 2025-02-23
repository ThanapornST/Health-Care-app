import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class DailyActivityCard extends StatelessWidget {
  final int caloriesConsumed; 
  final int caloriesBurned; 
  final int remainingCalories; 
  final String sleepTime; 

  const DailyActivityCard({
    required this.caloriesConsumed,
    required this.caloriesBurned,
    required this.remainingCalories,
    required this.sleepTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20), 
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), // เงาสำหรับ Container
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              _buildIconText(Icons.restaurant, "รับประทาน cal: $caloriesConsumed"), 
              _buildIconText(Icons.flash_on, "เผาผลาญ cal: $caloriesBurned"), 
            ],
          ),
          const SizedBox(height: 8), 
          const Text(
            "วันนี้คุณยังรับประทานได้อีก",
            style: TextStyle(fontSize: 14, color: AppColors.textPrimary), 
          ),
          const SizedBox(height: 4), 
          Text(
            "$remainingCalories kcal", 
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10), 


          _buildProgressBar(),
          const SizedBox(height: 20), 

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Text(
                "เวลานอน: $sleepTime น.", 
                style:const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              ),
            ],
          ),

          // เพิ่มคำแนะนำ
          const SizedBox(height: 10),
          _buildSuggestionText(),
        ],
      ),
    );
  }

  // Widget สำหรับสร้างแถวที่มีไอคอนและข้อความ
  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.iconColor), // ไอคอน
        const SizedBox(width: 4), // ระยะห่างระหว่างไอคอนและข้อความ
        Text(
          text,
          style:const TextStyle(fontSize: 14, color: AppColors.textPrimary), // ข้อความ
        ),
      ],
    );
  }

  // Widget สำหรับสร้าง Progress Bar
  Widget _buildProgressBar() {
    double progress = caloriesBurned / (caloriesConsumed > 0 ? caloriesConsumed : 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "สัดส่วนแคลอรีที่เผาผลาญ",
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress > 1 ? 1 : progress, // จำกัดค่า progress ไม่ให้เกิน 1
          backgroundColor: Colors.grey[300],
          color: AppColors.secondary,
          minHeight: 8,
        ),
        const SizedBox(height: 5),
        Text(
          "${(progress * 100).toStringAsFixed(1)}% ของแคลอรีที่บริโภค",
          style:const TextStyle(fontSize: 12, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  // Widget สำหรับคำแนะนำเพิ่มเติม
  Widget _buildSuggestionText() {
    if (remainingCalories > 0) {
      return Text(
        "คุณยังสามารถบริโภคเพิ่มได้อีก $remainingCalories แคลอรี่",
        style:const TextStyle(fontSize: 14, color: Colors.green),
      );
    } else if (remainingCalories < 0) {
      return Text(
        "คุณบริโภคเกินไป ${remainingCalories.abs()} แคลอรี่แล้ว!",
        style:const TextStyle(fontSize: 14, color: Colors.red),
      );
    } else {
      return const Text(
        "คุณบริโภคแคลอรี่ได้พอดีเป้าหมายแล้ว!",
        style: TextStyle(fontSize: 14, color: Colors.blue),
      );
    }
  }
}
