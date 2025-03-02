import 'package:appfinal/data/dummy_events.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({super.key});

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  DateTime today = DateTime.now();
  Map<DateTime, Map<String, String>> plans = dummyPlans; // ใช้โครงสร้างใหม่

  // ฟังก์ชันที่ทำงานเมื่อเลือกวันที่
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dailyPlans = plans[today] ?? {}; // ดึงข้อมูลของวันปัจจุบัน

    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Calendar with Daily Plan'),
        backgroundColor: AppColors.secondary,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'en_us',
            rowHeight: 35,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: today,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2030, 01, 01),
            eventLoader: (day) {
              return plans.containsKey(day) ? plans[day]!.values.toList() : [];
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              markerDecoration: BoxDecoration(
                color: AppColors.iconColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Daily Plan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: dailyPlans.isEmpty
                ? const Center(
                    child: Text("ไม่มีแผนสำหรับวันนี้ 😊",
                        style: TextStyle(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    itemCount: dailyPlans.length,
                    itemBuilder: (context, index) {
                      final period = dailyPlans.keys.elementAt(index);
                      final recommendation = dailyPlans[period]!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Card(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColors.secondary),
                          ),
                          child: ListTile(
                            title: Text(
                              "$period: $recommendation",
                              style:
                                  const TextStyle(color: AppColors.textPrimary),
                            ),
                            leading: const Icon(Icons.lightbulb,
                                color: AppColors.iconColor),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
