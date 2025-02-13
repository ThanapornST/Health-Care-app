import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class DailyActivityCard extends StatelessWidget {
  final int caloriesConsumed; // จำนวนแคลอรีที่บริโภค
  final int caloriesBurned; // จำนวนแคลอรีที่เผาผลาญ
  final int remainingCalories; // จำนวนแคลอรีที่เหลือ
  final String sleepTime; // เวลานอน

  DailyActivityCard({
    required this.caloriesConsumed,
    required this.caloriesBurned,
    required this.remainingCalories,
    required this.sleepTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // ใช้สีหลักเป็นพื้นหลัง
        borderRadius: BorderRadius.circular(20), // มุมกลม
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), // เงาสำหรับ Container
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // แสดงไอคอนในตำแหน่งซ้ายและขวา
            children: [
              _buildIconText(Icons.restaurant, "รับประทาน cal: $caloriesConsumed"), // แสดงแคลอรีที่บริโภค
              _buildIconText(Icons.flash_on, "เผาผลาญ cal: $caloriesBurned"), // แสดงแคลอรีที่เผาผลาญ
            ],
          ),
          const SizedBox(height: 8), // เว้นระยะห่าง
          Text(
            "วันนี้คุณยังรับประทานได้อีก",
            style: TextStyle(fontSize: 14, color: AppColors.textPrimary), // ข้อความหัวเรื่อง
          ),
          const SizedBox(height: 4), // เว้นระยะห่าง
          Text(
            "$remainingCalories kcal", // แสดงแคลอรีที่เหลือ
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10), // เว้นระยะห่าง
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดตำแหน่งเนื้อหาในแนวนอน
            children: [
              Text(
                "เวลานอน: $sleepTime น.", // แสดงเวลานอน
                style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
              ),
            ],
          ),
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
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary), // ข้อความ
        ),
      ],
    );
  }
}
