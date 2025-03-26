import 'package:flutter/material.dart';
import 'package:appfinal/services/gemini_service.dart'; // เรียกใช้ Gemini API

class HealthAdviceScreen extends StatefulWidget {
  final int age;
  final String gender;
  final double weight;
  final double height;
  final String goal;
  final Map<String, dynamic> recommendation; // ✅ เพิ่มรับ recommendation
  final Map<String, Map<String, int>> splitMeals; // ✅ เพิ่มรับ splitMeals

  const HealthAdviceScreen({
    super.key,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.goal,
    required this.recommendation, // ✅ เพิ่ม
    required this.splitMeals, // ✅ เพิ่ม
  });

  @override
  State<HealthAdviceScreen> createState() => _HealthAdviceScreenState();
}

class _HealthAdviceScreenState extends State<HealthAdviceScreen> {
  bool isLoading = true;

  @override
void fetchAdvice() async {
  try {
    String response = await GeminiService.getHealthAdvice(
      widget.age,
      widget.gender,
      widget.weight,
      widget.height,
      widget.goal,
    );

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text(
          '🌷 คำแนะนำสุขภาพ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFAAF90),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // ✅ เพิ่มเลื่อนหน้า
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('🌸 สรุปคำแนะนำวันนี้', color: Colors.pink.shade200),
              const SizedBox(height: 15),

              _buildSummaryRow("🏋️‍♀️ ออกกำลังกาย", "${widget.recommendation['exercise']} นาที"),
              _buildSummaryRow("🍗 โปรตีน", "${widget.recommendation['protein']} กรัม"),
              _buildSummaryRow("🍚 คาร์โบไฮเดรต", "${widget.recommendation['carb']} กรัม"),
              const SizedBox(height: 20),

              _buildHeader('🍽️ รายมื้ออาหาร', color: Colors.orange.shade200),
              const SizedBox(height: 15),

              _buildMealCard('🌅 มื้อเช้า', widget.splitMeals['มื้อเช้า']!),
              const SizedBox(height: 12),
              _buildMealCard('🏙️ มื้อกลางวัน', widget.splitMeals['มื้อกลางวัน']!),
              const SizedBox(height: 12),
              _buildMealCard('🌙 มื้อเย็น', widget.splitMeals['มื้อเย็น']!),

              const SizedBox(height: 20), // ✅ ป้องกันเนื้อหาติดขอบล่าง
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.favorite, color: Colors.white),
          label: const Text('บันทึกกิจกรรมและอาหาร', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFAAF90),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text, {required Color color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Kanit',
        ),
      ),
    );
  }

  Widget _buildMealCard(String meal, Map<String, int> nutrients) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meal,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("คาร์โบไฮเดรต: ${nutrients['carb'] ?? '-'} กรัม",
                    style: const TextStyle(fontSize: 16, fontFamily: 'Kanit')),
                Text("โปรตีน: ${nutrients['protein'] ?? '-'} กรัม",
                    style: const TextStyle(fontSize: 16, fontFamily: 'Kanit')),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            Text("🍖 โปรตีน: เนื้อสัตว์, ไข่, นม, ถั่วเมล็ดแห้ง", style: const TextStyle(fontSize: 14, fontFamily: 'Kanit')),
            Text("🍚 คาร์โบไฮเดรต: ข้าว, เผือก, มัน, น้ำตาล", style: const TextStyle(fontSize: 14, fontFamily: 'Kanit')),
            Text("🥦 วิตามินและเกลือแร่: ผัก, ผลไม้", style: const TextStyle(fontSize: 14, fontFamily: 'Kanit')),
            Text("🧈 ไขมัน: ไขมันจากสัตว์และพืช", style: const TextStyle(fontSize: 14, fontFamily: 'Kanit')),
            Text("💧 น้ำ: ควรดื่มน้ำเพียงพอ", style: const TextStyle(fontSize: 14, fontFamily: 'Kanit')),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Kanit')),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green, fontFamily: 'Kanit')),
        ],
      ),
    );
  }
}
