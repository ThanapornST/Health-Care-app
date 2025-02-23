import 'package:flutter/material.dart';

class SummarizePage extends StatefulWidget {
  final int caloriesConsumed;
  final int caloriesBurned;
  final int remainingCalories;
  final double bmr;

  const SummarizePage({
    super.key,
    this.caloriesConsumed = 0,
    this.caloriesBurned = 0,
    this.remainingCalories = 0,
    this.bmr = 0.0,
  });

  @override
  State<SummarizePage> createState() => _SummarizePageState();
}

class _SummarizePageState extends State<SummarizePage> {
  @override
  Widget build(BuildContext context) {
    double percentageBurned = widget.caloriesConsumed > 0
        ? (widget.caloriesBurned / widget.caloriesConsumed) * 100
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('สรุปข้อมูล'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 63, 44),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "📊 ข้อมูลสรุปสุขภาพ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.restaurant, color: Colors.green),
                      title: Text("🍽️ รับประทาน: ${widget.caloriesConsumed} kcal"),
                      subtitle: Text("💪 BMR: ${widget.bmr.toStringAsFixed(2)} kcal/day"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.local_fire_department, color: Colors.red),
                      title: Text("🔥 เผาผลาญ: ${widget.caloriesBurned} kcal"),
                      subtitle: Text("${percentageBurned.toStringAsFixed(1)}% ของแคลอรี่ที่บริโภค"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_circle, color: Colors.blue),
                      title: Text("⚖️ แคลอรี่ที่เหลือ: ${widget.remainingCalories} kcal"),
                      subtitle: Text(
                        widget.remainingCalories > 0
                            ? "✅ คุณยังรับประทานได้อีก ${widget.remainingCalories} kcal"
                            : "⚠️ คุณบริโภคเกินเป้าหมายแล้ว!",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
