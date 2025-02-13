// เมนูของหวาน
import 'package:appfinal/data/datasubscreen/dummy_dessert_menu.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class DessertMenuScreen extends StatefulWidget {
  final Function(String title, String calorie)?
      onSelectMenu; // Callback สำหรับส่งข้อมูลกลับไปยังหน้าหลัก

  const DessertMenuScreen({super.key, this.onSelectMenu});

  @override
  State<DessertMenuScreen> createState() => _DessertMenuScreenState();
}

class _DessertMenuScreenState extends State<DessertMenuScreen> {
  List<int> _itemCounts = List.generate(dummydessertMenu.length, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dessert Menu'),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
      ),
      body: ListView.builder(
        itemCount: dummydessertMenu.length,
        itemBuilder: (ctx, index) {
          final menu = dummydessertMenu[index];
          return InkWell(
            onTap: () {
              // เพิ่มการเรียกใช้ Callback ส่งชื่อและแคลอรีกลับไปยังหน้าหลัก
              if (widget.onSelectMenu != null) {
                widget.onSelectMenu!(menu.titledessert, menu.caloriedessert);
              }
              Navigator.pop(context); // ปิดหน้าปัจจุบัน
            },
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
                          menu.imageUrldessert,
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
                                menu.titledessert,
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Calories: ${menu.caloriedessert}',
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
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.secondary,
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
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ปุ่มใหม่ด้านล่างรูปสำหรับส่งข้อมูล
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.onSelectMenu != null) {
                          widget.onSelectMenu!(menu.titledessert,
                              menu.caloriedessert); // ส่งชื่อและแคลอรีกลับไป
                        }

                        // ส่งแคลอรีที่เลือกกลับไปยังหน้าหลัก
                        Navigator.pop(context); // ปิดหน้าปัจจุบัน
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('เลือกเมนูนี้'),
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
