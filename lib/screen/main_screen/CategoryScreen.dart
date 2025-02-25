import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfinal/screen/sub_screen/BeverageMenu.dart';
import 'package:appfinal/screen/sub_screen/DessertMenu.dart';
import 'package:appfinal/screen/sub_screen/FruitMenu.dart';
import 'package:appfinal/screen/sub_screen/MainManu.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Map<String, dynamic>>> mealsFuture;

  @override
  void initState() {
    super.initState();
    mealsFuture = fetchMealsFromFirestore();
  }

  // ✅ ดึงข้อมูล `dummyMeals` จาก Firestore
  Future<List<Map<String, dynamic>>> fetchMealsFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('dummyMeals').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // ✅ ฟังก์ชันเปิดหน้าต่างๆ ตาม `categoryId`
  void _selectCategory(BuildContext context, String categoryId) {
    if (categoryId == 'c1') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    } else if (categoryId == 'c2') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FruitMenuScreen()),
      );
    } else if (categoryId == 'c3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DessertMenuScreen()),
      );
    } else if (categoryId == 'c4') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BeverageMenuScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Calories'),
        backgroundColor: AppColors.secondary,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: mealsFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("ไม่มีข้อมูลเมนู"));
          }

          final meals = snapshot.data!;

          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) {
              final meal = meals[index];

              return InkWell(
                onTap: () {
                  _selectCategory(context, meal['categories'][0]); 
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
                              meal['imageUrl'], 
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
                              child: Text(
                                meal['title'],
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
