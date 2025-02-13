import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';


class SleepingPage extends StatefulWidget {
  const SleepingPage({super.key});

  @override
  State<SleepingPage> createState() => _SleepingPageState();
}

class _SleepingPageState extends State<SleepingPage> {
  // เวลาที่นอน และ เวลาตื่น (ค่าเริ่มต้น)
  TimeOfDay sleepTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay wakeUpTime = const TimeOfDay(hour: 6, minute: 0);

  // ฟังก์ชันคำนวณจำนวนชั่วโมงที่นอน
  String getSleepDuration() {
    final sleepMinutes = (wakeUpTime.hour * 60 + wakeUpTime.minute) -
        (sleepTime.hour * 60 + sleepTime.minute);
    final hours = sleepMinutes ~/ 60;
    final minutes = sleepMinutes % 60;
    return "$hours ชั่วโมง ${minutes > 0 ? "$minutes นาที" : ""}";
  }

  // ฟังก์ชันเลือกเวลา
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
      backgroundColor: AppColors.background, // ใช้สีพื้นหลัง
      appBar: AppBar(
        title: const Text(
          "การพักผ่อนวันนี้",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
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
          ],
        ),
      ),
    );
  }

  // การ์ดแสดงเวลาที่นอนและเวลาตื่น
  Widget _buildSleepCard(String title, TimeOfDay time, bool isSleepTime, IconData icon) {
    return GestureDetector(
      onTap: () => _selectTime(context, isSleepTime),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
              ],
            ),
            Text(
              "${time.format(context)} น.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  // การ์ดสรุปชั่วโมงที่นอน
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.nightlight_round, size: 22, color: Colors.white),
              const SizedBox(width: 10),
              const Text(
                "นอนทั้งหมด",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          Text(
            getSleepDuration(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
