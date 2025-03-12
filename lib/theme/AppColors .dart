import 'package:flutter/material.dart';

class AppColors {
  // 🎨 สีหลัก (โทนพีช ชมพู ครีม)
  static const Color primary = Color(0xFFFFF5EC); // พื้นหลังครีมอ่อน
  static const Color secondary = Color(0xFFFFB4A2); // ส้มพีชอ่อน (หัวข้อ ปุ่มเด่น)
  static const Color iconColor = Color(0xFF6D6875); // เทาอมม่วง (ไอคอน/ตัวหนังสือเข้ม)

  // 🎨 สีพื้นหลัง
  static const Color background = primary; // พื้นหลังหลัก
  static const Color darkBackground = Color(0xFFFFE5D9); // พื้นหลังเข้มขึ้น (พีชอ่อน)

  // 🎨 สีข้อความ
  static const Color textPrimary = Color(0xFF4A4E69); // เทาเข้ม อ่านง่าย
  static const Color textSecondary = Colors.white; // ข้อความบนปุ่มสีเข้ม

  // 🎨 สีพาสเทลเสริม (ไว้แต่งปุ่ม, card)
  static const Color accentPink = Color(0xFFFDCBDF); // ชมพูอ่อน (หวานๆ)
  static const Color accentYellow = Color(0xFFFFE066); // เหลืองพาสเทล
  static const Color accentPeach = Color(0xFFFFD6BA); // พีชอ่อน
  static const Color accentPurple = Color(0xFFB8B8FF); // ม่วงพาสเทล (สำรอง)
}
