// เมนูผลไม้
import 'package:appfinal/data/datasubscreen/dummy_mainmenu.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class FruitManuScreen extends StatefulWidget {
  final Function(String title, String calorie)?
      onSelectMenu; // Callback สำหรับส่งข้อมูลกลับไปยังหน้าหลัก

  const FruitManuScreen({super.key, this.onSelectMenu});

  @override
  State<FruitManuScreen> createState() => _FruitManuScreenState();
}

class _FruitManuScreenState extends State<FruitManuScreen> {
  List<int> _itemCounts = List.generate(dummyMainMenu.length, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Menu'),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
      ),
      body: ListView.builder(
        itemCount: dummyMainMenu.length,
        itemBuilder: (ctx, index) {
          final menu = dummyMainMenu[index];
          return Card(
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
                        widget.onSelectMenu!(menu.titleMain,
                            menu.calorieMain); // ส่งชื่อและแคลอรีกลับไป
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
          );
        },
      ),
    );
  }
}
