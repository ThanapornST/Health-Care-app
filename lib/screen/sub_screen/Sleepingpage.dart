import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';
import 'package:appfinal/services/firestore_service.dart';

class SleepingPage extends StatefulWidget {
  const SleepingPage({super.key});

  @override
  State<SleepingPage> createState() => _SleepingPageState();
}

class _SleepingPageState extends State<SleepingPage> {
  TimeOfDay sleepTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay wakeUpTime = const TimeOfDay(hour: 6, minute: 0);
  final FirestoreService _firestoreService = FirestoreService();
  
  String? userUUID; 

  @override
  void initState() {
    super.initState();
    _initializeUser(); 
  }

  // ✅ ฟังก์ชันดึง UUID หรือสร้างใหม่ถ้ายังไม่มี
  Future<void> _initializeUser() async {
    userUUID = await _firestoreService.getOrCreateUserUUID();
    setState(() {}); 
  }

  // ฟังก์ชันคำนวณจำนวนชั่วโมงที่นอน
  double getSleepDuration() {
    int sleepMinutes = (wakeUpTime.hour * 60 + wakeUpTime.minute) -
        (sleepTime.hour * 60 + sleepTime.minute);

    if (sleepMinutes < 0) {
      sleepMinutes += 24 * 60; 
    }

    return sleepMinutes / 60.0; 
  }

  Future<void> _selectTime(BuildContext context, bool isSleepTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isSleepTime ? sleepTime : wakeUpTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isSleepTime) {
          sleepTime = pickedTime;
        } else {
          wakeUpTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("การพักผ่อนวันนี้"),
        backgroundColor: AppColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "⏳ สรุปเวลาพักผ่อน",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSleepCard("เวลาที่นอน", sleepTime, true, Icons.bedtime),
            const SizedBox(height: 12),
            _buildSleepCard("ตื่นกี่โมง", wakeUpTime, false, Icons.wb_sunny),
            const SizedBox(height: 12),
            _buildSummaryCard(),
            const SizedBox(height: 20),

            // ปุ่มบันทึก
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  double sleepHours = getSleepDuration();

                  try {
                    if (userUUID != null) {
                      // ✅ บันทึกข้อมูลการนอนลง Firestore (ใน UUID เดิมของผู้ใช้)
                      await _firestoreService.logSleepEntry(sleepHours);

                      print("✅ บันทึกเวลานอนสำเร็จใน UUID: $userUUID");
                    } else {
                      print("❌ ไม่พบ UUID ของผู้ใช้");
                    }
                  } catch (e) {
                    print("❌ Error saving sleep data: $e");
                  }

                  Navigator.pop(context, sleepHours.toString()); // ส่งข้อมูลกลับ
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "บันทึกเวลาการพักผ่อน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepCard(String title, TimeOfDay time, bool isSleepTime, IconData icon) {
    return GestureDetector(
      onTap: () => _selectTime(context, isSleepTime),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 22, color: AppColors.secondary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style:const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                ),
              ],
            ),
            Text(
              "${time.format(context)} น.",
              style:const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
               Icon(Icons.nightlight_round, size: 22, color: Colors.white),
               SizedBox(width: 10),
               Text(
                "นอนทั้งหมด",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Text(
            "${getSleepDuration().toStringAsFixed(1)} ชั่วโมง",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
