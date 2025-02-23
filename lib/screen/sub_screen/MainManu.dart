import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfinal/services/firestore_service.dart';

class MainMenuScreen extends StatefulWidget {
  final Function(String title, String calorie, int count)? onSelectMenu;

  const MainMenuScreen({super.key, this.onSelectMenu});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  List<int> _itemCounts = [];
  List<DocumentSnapshot> _mainMenus = [];
  String? userUUID; // ตัวแปรเก็บ UUID ของผู้ใช้

  @override
  void initState() {
    super.initState();
    _initializeUser(); // ✅ ดึงหรือสร้าง UUID ของผู้ใช้
    _fetchData();
  }

  // ✅ ฟังก์ชันดึง UUID หรือสร้างใหม่ถ้ายังไม่มี
  Future<void> _initializeUser() async {
    userUUID = await _firestoreService.getOrCreateUserUUID();
    setState(() {}); // อัปเดต UI หลังจากได้ UUID
  }

  Future<void> _fetchData() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('dummyMain').get();
      setState(() {
        _mainMenus = snapshot.docs;
        _itemCounts = List.generate(snapshot.docs.length, (index) => 0);
      });
    } catch (e) {
      print("❌ Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Course Menu'),
        backgroundColor: AppColors.secondary,
      ),
      body: _mainMenus.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _mainMenus.length,
              itemBuilder: (ctx, index) {
                final menuData = _mainMenus[index].data() as Map<String, dynamic>;

                final String title = menuData['titleMain'] ?? 'No Title';
                final String calorie = menuData['calorieMain'] ?? '0 kcal';
                final String imageUrl = menuData['imageUrlMain'] ?? '';

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
                              imageUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported, size: 100),
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
                                    title,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Calories: $calorie',
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
                              icon:const Icon(Icons.remove, color: AppColors.iconColor),
                              label: const Text("Remove"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.secondary,
                              ),
                            ),
                            Text(
                              _itemCounts[index].toString(),
                              style:const TextStyle(
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
                              icon:const Icon(Icons.add, color: AppColors.iconColor),
                              label: const Text("Add"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (widget.onSelectMenu != null) {
                              widget.onSelectMenu!(title, calorie, _itemCounts[index]);
                            }

                            try {
                              if (userUUID != null) {
                                // ✅ บันทึกลง Firestore (ใน UUID เดิมของผู้ใช้)
                                await _firestoreService.logFoodEntry(
                                  title,
                                  int.parse(calorie.replaceAll(RegExp(r'[^0-9]'), '')),
                                  imageUrl,
                                  "Main Course",
                                );

                                print("✅ บันทึกข้อมูลเมนูหลักสำเร็จ: $title ($calorie kcal)");
                              } else {
                                print("❌ ไม่พบ UUID ของผู้ใช้");
                              }
                            } catch (e) {
                              print("❌ Error saving main course data: $e");
                            }

                            Navigator.pop(context);
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
