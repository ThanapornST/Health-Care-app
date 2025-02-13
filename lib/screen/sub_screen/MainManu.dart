// เมนูอาหารหลัก
import 'package:appfinal/data/datasubscreen/dummy_mainmenu.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class MainManuScreen extends StatefulWidget {
  final Function(String title, String calorie)? onSelectMenu; // เพิ่ม Callback เพื่อส่งข้อมูลกลับ


  const MainManuScreen({super.key, this.onSelectMenu});

  @override
  State<MainManuScreen> createState() => _MainManuScreenState();
}

class _MainManuScreenState extends State<MainManuScreen> {
  List<int> _itemCounts = List.generate(dummyMainMenu.length, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Calories'),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
      ),
      body: ListView.builder(
        itemCount: dummyMainMenu.length,
        itemBuilder: (ctx, index) {
          final menu = dummyMainMenu[index];
          return InkWell(
               onTap: () {
              if (widget.onSelectMenu != null) { // ตรวจสอบ Callback
                widget.onSelectMenu!(menu.titleMain, menu.calorieMain); // ส่งข้อมูลกลับผ่าน Callback
              }
              Navigator.pop(context); // กลับไปยังหน้าเดิมหลังเลือก
            }, // เพิ่ม Callback เมื่อกดเลือกเมนู
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          menu.imageUrlMain,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                          width: 300,
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.titleMain,
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Calories: ${menu.calorieMain}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ปุ่มลบทางซ้าย
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (_itemCounts[index] > 0) {
                                _itemCounts[index]--;
                              }
                            });
                          },
                          icon: Icon(Icons.remove, color: AppColors.iconColor),
                          label: const Text("Remove"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary, // ใช้สีหลัก
                            foregroundColor: AppColors.secondary, // สีตัวอักษร
                          ),
                        ),
                        Text(
                          _itemCounts[index].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _itemCounts[index]++;
                            });
                          },
                          icon: Icon(Icons.add, color: AppColors.iconColor),
                          label: const Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary, // ใช้สีหลัก
                            foregroundColor: AppColors.secondary, // สีตัวอักษร
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
