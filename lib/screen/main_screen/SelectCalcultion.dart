import 'package:appfinal/screen/main_screen/CategoryScreen.dart';
import 'package:appfinal/screen/main_screen/ExercisePage.dart';
import 'package:appfinal/screen/main_screen/SummarizePage.dart';
import 'package:appfinal/screen/main_screen/Table_Calendar.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:appfinal/widget/button/button_page.dart';
import 'package:flutter/material.dart';

class SelectCalcultion extends StatefulWidget {
  final String? name; // ชื่อผู้ใช้
  final String? imageUrl; // URL ของภาพผู้ใช้
  final String? logoUrl; // โลโก้ (ถ้ามี)
  final String height; // ส่วนสูงของผู้ใช้
  final String weight; // น้ำหนักของผู้ใช้

  const SelectCalcultion({
    this.name,
    this.imageUrl,
    this.logoUrl,
    required this.height,
    required this.weight,
    super.key,
  });

  @override
  State<SelectCalcultion> createState() => _SelectCalcultionState();
}

class _SelectCalcultionState extends State<SelectCalcultion> {
  int _totalCalories = 0; // ตัวแปรเก็บจำนวนแคลอรีที่รับประทานรวมทั้งหมด

  // ฟังก์ชันเพิ่มจำนวนแคลอรี
  void _addCalories(String title, String calorie) {
    setState(() {
      _totalCalories += int.parse(calorie); // เพิ่มจำนวนแคลอรีจากเมนูที่เลือก
    });
  }

  List<Widget> _pages = []; // รายการหน้าจอในแอป

  @override
  void initState() {
    super.initState();
    _pages = [
      SelectCalcultion(
        height: widget.height,
        weight: widget.weight,
      ),
      // หน้าจอต่าง ๆ ในแอป
      CategoryScreen(), // หน้าเลือกหมวดหมู่
      SummarizePage(), // หน้าสรุปข้อมูล
      TableCalendarScreen(), // หน้าตารางปฏิทิน
      ExerciseScreen(), // หน้าออกกำลังกาย
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 63, 44), // สีพื้นหลัง AppBar
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.350, // ความสูงส่วนหัว
                decoration: const BoxDecoration(
                  color: AppColors.secondary, // ใช้สีรอง
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
                          // รูปโปรไฟล์ผู้ใช้
                          ClipOval(
                            child: Image.network(
                              widget.imageUrl ??
                                  'https://i.pinimg.com/736x/6c/04/f4/6c04f47686c8e86bb4da000ffeceb330.jpg', // URL รูปภาพสำรอง
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error, size: 60); // กรณีโหลดรูปภาพไม่ได้
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // แสดงส่วนสูง
                                Text(
                                  'Height: ${widget.height} cm',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // แสดงน้ำหนัก
                                Text(
                                  'Weight: ${widget.weight} kg',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // แสดงวันที่ปัจจุบัน
                                Text(
                                  'Date: ${DateTime.now().toString().split(' ')[0]}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // กล่องแสดงข้อมูลแคลอรี
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.secondary,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.restaurant,
                                    size: 30,
                                    color: AppColors.iconColor, // ไอคอนแสดงการรับประทาน
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "รับประทาน cal",
                                    style: TextStyle(color: AppColors.textPrimary),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              // แสดงจำนวนแคลอรีที่รับประทาน
                              Text(
                                "$_totalCalories kcal", // ใช้ตัวแปร _totalCalories
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.bolt,
                                    size: 30,
                                    color: AppColors.iconColor, // ไอคอนแสดงการเผาผลาญ
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "เผาผลาญ cal",
                                    style: TextStyle(color: AppColors.textPrimary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // ส่วนเพิ่มเติม เช่น ลิงก์ไปหน้าสรุปข้อมูล
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SummarizePage(),
                              ),
                            );
                          },
                          child: const Text(
                            "ดูเพิ่มเติม",
                            style: TextStyle(
                              color: AppColors.iconColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 1),
          // ปุ่มต่าง ๆ ในแอป
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ButtonPage(),
            ),
          ),
        ],
      ),
    );
  }
}
