//ปุ่มเลือกหมวดหมู่หน้าแรก
// ปุ่มเลือกหมวดหมู่หน้าแรก
import 'package:appfinal/screen/main_screen/CalculatePage.dart';
import 'package:appfinal/screen/main_screen/CategoryScreen.dart';
import 'package:appfinal/screen/main_screen/Sleepingpage.dart';
import 'package:appfinal/screen/main_screen/Table_Calendar.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          _buildCategoryButton(
            context,
            icon: Icons.fastfood,
            label: "การรับประทานอาหาร",
            description: "กรอกข้อมูลอาหารที่รับประทานในแต่ละวัน",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            ),
          ),
          _buildCategoryButton(
            context,
            icon: Icons.calculate,
            label: "คำนวณแคลอรี่",
            description: "ช่วยในการคำนวณแคลอรี่ในแต่ละวัน",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalculatePage()),
            ),
          ),
          _buildCategoryButton(
            context,
            icon: Icons.calendar_today,
            label: "จัดตาราง",
            description: "ช่วยจัดตารางแนะนำในแต่ละสัปดาห์",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TableCalendarScreen()),
            ),
          ),
          _buildCategoryButton(
            context,
            icon: Icons.bed,
            label: "การพักผ่อน",
            description: "กรอกช่วงเวลาการพักผ่อนในแต่ละวัน",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SleepingPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.white, // ใช้สีพื้นหลัง
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: AppColors.secondary, // ใช้สีขอบ
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: AppColors.iconColor),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary, // ใช้สีตัวอักษร
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
