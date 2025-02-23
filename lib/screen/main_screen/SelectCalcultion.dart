//หน้าหลัก
import 'package:appfinal/screen/main_screen/CalculatePage.dart';
import 'package:appfinal/screen/main_screen/CategoryScreen.dart';
import 'package:appfinal/screen/sub_screen/ExercisePage.dart';
import 'package:appfinal/screen/main_screen/SummarizePage.dart';
import 'package:appfinal/screen/main_screen/Table_Calendar.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:appfinal/widget/button/button_page.dart';
import 'package:flutter/material.dart';

class SelectCalcultion extends StatefulWidget {
  final String? name;
  final String? imageUrl;
  final String? logoUrl;
  final String height;
  final String weight;

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
  int _totalCalories = 0;
  int _burnedCalories = 0;

  // รายการอาหารและกิจกรรม
  List<Map<String, String>> _consumedItems = [];
  List<Map<String, String>> _burnedItems = [];

  // เพิ่มเมนูอาหาร
  void _addCalories(String title, String calorie) {
    setState(() {
      int cal = int.parse(calorie);
      _totalCalories += cal;
      _consumedItems.add({"title": title, "calorie": "$cal kcal"});
    });
  }

  // เพิ่มกิจกรรมเผาผลาญ
  void _updateBurnedCalories(String title, String burned) {
    setState(() {
      int cal = int.parse(burned);
      _burnedCalories += cal;
      _burnedItems.add({"title": title, "calorie": "$cal kcal"});
    });
  }

  List<Widget> _pages = [];

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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 63, 44),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // ส่วนหัว
              Container(
                height: MediaQuery.of(context).size.height * 0.400,
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
                          // รูปโปรไฟล์ผู้ใช้
                          ClipOval(
                            child: Image.network(
                              widget.imageUrl ??
                                  'https://i.pinimg.com/736x/6c/04/f4/6c04f47686c8e86bb4da000ffeceb330.jpg',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error, size: 60);
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Height: ${widget.height} cm',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Weight: ${widget.weight} kg',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
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
              // กล่องแสดงข้อมูลแคลอรี่
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
                      // แสดงแคลอรี่รวม
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ทำไมต้องอ่านเล่มนี้",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('1. ประโยชน์\n1.1 ใครก็สามารถทำได้'),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '2. เหตุผล\n2.1 กระบวนการที่สร้างความเข้าใจง่าย'),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ✅ แสดงรายการอาหารที่เลือก
                      if (_consumedItems.isNotEmpty) ...[
                        const Text(
                          "🍽️ เมนูอาหารที่เลือก:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _consumedItems.length,
                          itemBuilder: (context, index) {
                            final item = _consumedItems[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(item['title']!),
                              trailing: Text(item['calorie']!),
                            );
                          },
                        ),
                      ],

                      const SizedBox(height: 10),

                      // ✅ แสดงรายการกิจกรรมเผาผลาญ
                      if (_burnedItems.isNotEmpty) ...[
                        const Text(
                          "🔥 กิจกรรมที่เลือก:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _burnedItems.length,
                          itemBuilder: (context, index) {
                            final item = _burnedItems[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(item['title']!),
                              trailing: Text(item['calorie']!),
                            );
                          },
                        ),
                      ],

                      const SizedBox(height: 20),

                      // ปุ่ม "ดูเพิ่มเติม"
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>const CalculatePage(
                                ),
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
