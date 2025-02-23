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
  Map<DateTime, List<String>> events = dummyEvents; // Use dummy events

  // ฟังก์ชันเพื่อหาวันเริ่มต้นและวันสิ้นสุดของสัปดาห์
  List<DateTime> getWeekDays(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  // ฟังก์ชันแสดงกิจกรรมในสัปดาห์ปัจจุบัน
  List<String> getWeeklyEvents(DateTime date) {
    final weekDays = getWeekDays(date);
    List<String> weeklyEvents = [];
    for (var day in weekDays) {
      if (events[day] != null) {
        weeklyEvents.addAll(events[day]!);
      }
    }
    return weeklyEvents;
  }

  // ฟังก์ชันที่ทำงานเมื่อเลือกวันที่
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    _showAddNoteDialog(day);
  }

  // ฟังก์ชันกำหนดสีพื้นหลังของแผนตามประเภทกิจกรรม
  Color getPlanColor(String planType) {
    switch (planType) {
      case 'Exercise':
        return Colors.lightBlue[100]!;
      case 'Diet':
        return Colors.green[100]!;
      case 'Sleep':
        return Colors.purple[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  // กล่องข้อความเพื่อเพิ่มโน้ต
  void _showAddNoteDialog(DateTime selectedDay) {
    TextEditingController _noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note for ${selectedDay.toLocal()}'),
          content: TextField(
            controller: _noteController,
            decoration: const InputDecoration(hintText: 'Enter your note here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_noteController.text.isNotEmpty) {
                  setState(() {
                    if (events[selectedDay] == null) {
                      events[selectedDay] = [];
                    }
                    events[selectedDay]?.add(_noteController.text);
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Calendar with Weekly View'),
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
              return events[day] ?? [];
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              todayTextStyle:  TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle:  TextStyle(
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
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Weekly Plan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: getWeeklyEvents(today).length,
                    itemBuilder: (context, index) {
                      final weeklyEvents = getWeeklyEvents(today);
                      final event = weeklyEvents[index];
                      final planType = event.split(':')[0]; 

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          color: getPlanColor(planType), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:const BorderSide(color: AppColors.secondary),
                          ),
                          child: ListTile(
                            title: Text(
                              event,
                              style:const TextStyle(color: AppColors.textPrimary),
                            ),
                            leading:const Icon(Icons.event_note,
                                color: AppColors.iconColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
