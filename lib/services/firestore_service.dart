import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userUUID; // ✅ เก็บ UUID ของผู้ใช้ในตัวแปรนี้

  // ✅ ฟังก์ชันเช็ค UUID และสร้างใหม่ถ้ายังไม่มี
  Future<String> getOrCreateUserUUID() async {
    if (userUUID != null) {
      return userUUID!;
    }

    try {
      // 🔹 ค้นหา UUID ของผู้ใช้จาก Firestore
      QuerySnapshot querySnapshot = await _firestore.collection('users').limit(1).get();
      
      if (querySnapshot.docs.isNotEmpty) {
        userUUID = querySnapshot.docs.first.id; // ใช้ UUID เดิม
      } else {
        userUUID = _firestore.collection('users').doc().id; // สร้าง UUID ใหม่
        await _firestore.collection('users').doc(userUUID).set({
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      print("✅ ใช้ UUID: $userUUID");
      return userUUID!;
    } catch (e) {
      print("❌ Error ดึงหรือสร้าง UUID: $e");
      rethrow;
    }
  }

  // ✅ ฟังก์ชันบันทึกข้อมูลผู้ใช้ (อายุ, น้ำหนัก, ส่วนสูง, เพศ)
  Future<void> saveUserData(int age, String gender, double height, double weight) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).set({
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    print("✅ บันทึกข้อมูลผู้ใช้สำเร็จ: UUID = $uuid");
  }

  // ✅ บันทึกข้อมูลอาหาร
  Future<void> logFoodEntry(String name, int calories, String image, String category) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).collection('food_logs').add({
      'name': name,
      'calories': calories,
      'image': image,
      'category': category,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("✅ บันทึกอาหารสำเร็จใน UUID: $uuid");
  }

  // ✅ บันทึกข้อมูลออกกำลังกาย
  Future<void> logExerciseEntry(String name, int duration, int caloriesBurned, String image) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).collection('exercise_logs').add({
      'name': name,
      'duration': duration,
      'calories_burned': caloriesBurned,
      'image': image,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("✅ บันทึกข้อมูลออกกำลังกายใน UUID: $uuid");
  }

  // ✅ บันทึกข้อมูลการนอน
  Future<void> logSleepEntry(double sleepHours) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).collection('sleep_logs').add({
      'sleep_hours': sleepHours,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("✅ บันทึกเวลานอนใน UUID: $uuid");
  }

  // ✅ ดึงข้อมูลผู้ใช้จาก Firestore
  Future<DocumentSnapshot> getUserData(String uuid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uuid).get();
      if (userDoc.exists) {
        print("✅ ดึงข้อมูลผู้ใช้สำเร็จ: ${userDoc.data()}");
      } else {
        print("❌ ไม่พบข้อมูลผู้ใช้สำหรับ UUID: $uuid");
      }
      return userDoc;
    } catch (e) {
      print("❌ Error ในการดึงข้อมูลผู้ใช้: $e");
      rethrow;
    }
  }

  // ✅ ดึงแคลอรี่ทั้งหมดที่บริโภค
  Future<int> getTotalCaloriesConsumed(String uuid) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').doc(uuid).collection('food_logs').get();

      int totalCalories = snapshot.docs.fold(0, (sum, doc) {
        int calories = (doc['calories'] ?? 0).toInt();
        return sum + calories;
      });

      print("✅ แคลอรี่ทั้งหมดที่บริโภค: $totalCalories kcal");
      return totalCalories;
    } catch (e) {
      print("❌ Error ในการดึงแคลอรี่ที่บริโภค: $e");
      return 0;
    }
  }

  // ✅ ดึงแคลอรี่ทั้งหมดที่เผาผลาญ
  Future<int> getTotalCaloriesBurned(String uuid) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').doc(uuid).collection('exercise_logs').get();

      int totalCaloriesBurned = snapshot.docs.fold(0, (sum, doc) {
        return sum + (int.tryParse(doc['calories_burned']?.toString() ?? '0') ?? 0);
      });

      print("✅ แคลอรี่ทั้งหมดที่เผาผลาญ: $totalCaloriesBurned kcal");
      return totalCaloriesBurned;
    } catch (e) {
      print("❌ Error ในการดึงแคลอรี่ที่เผาผลาญ: $e");
      return 0;
    }
  }

  // ✅ บันทึกแคลอรี่ที่เผาผลาญในแต่ละวัน
  Future<void> saveDailyCalories(int caloriesBurned) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).collection('daily_calories').add({
      'calories_burned': caloriesBurned,
      'date': Timestamp.now(),
    });

    print("✅ บันทึกแคลอรี่ที่เผาผลาญสำเร็จใน UUID: $uuid");
  }

  // ✅ บันทึกข้อมูลเพศ อายุ น้ำหนัก ส่วนสูง สำหรับใช้คำนวณ
  Future<void> saveUserMetrics(int age, String gender, double height, double weight) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).set({
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    }, SetOptions(merge: true));

    print("✅ บันทึกข้อมูลสุขภาพผู้ใช้สำเร็จใน UUID: $uuid");
  }

  // ✅ เพิ่มฟังก์ชันบันทึก BMR และ Remaining Calories
  Future<void> saveUserBMRAndRemainingCalories(double bmr, int remainingCalories) async {
    String uuid = await getOrCreateUserUUID();

    await _firestore.collection('users').doc(uuid).collection('user_metrics').doc('daily_metrics').set({
      'bmr': bmr,
      'remainingCalories': remainingCalories,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    print("✅ บันทึกค่า BMR: $bmr และ Remaining Calories: $remainingCalories สำเร็จ");
  }

  // ✅ ดึงค่า BMR และ Remaining Calories จาก Firestore
  Future<Map<String, dynamic>?> getUserBMRAndRemainingCalories() async {
    String uuid = await getOrCreateUserUUID();

    DocumentSnapshot doc = await _firestore.collection('users').doc(uuid).collection('user_metrics').doc('daily_metrics').get();

    if (doc.exists) {
      print("✅ โหลดค่า BMR และ Remaining Calories สำเร็จ: ${doc.data()}");
      return doc.data() as Map<String, dynamic>?;
    } else {
      print("❌ ไม่พบข้อมูล BMR และ Remaining Calories");
      return null;
    }
  }
}
