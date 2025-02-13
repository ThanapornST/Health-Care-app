// หน้าปฏิทิน
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
  Map<DateTime, List<String>> events = {};

  // ฟังก์ชันที่ทำงานเมื่อเลือกวันที่
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    _showAddNoteDialog(day);
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
        title: const Text('Table Calendar with Notes'),
        backgroundColor: AppColors.secondary, // ใช้สีรอง
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
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: AppColors.iconColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: events[today]?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(), // ใช้คีย์ที่ไม่ซ้ำสำหรับทุกๆ โน้ต
                  direction: DismissDirection.endToStart, // ปัดจากขวาไปซ้ายเพื่อลบ
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      events[today]?.removeAt(index); // ลบโน้ตออกจากรายการ
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note dismissed')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.secondary),
                      ),
                      child: ListTile(
                        title: Text(
                          events[today]?[index] ?? 'No Notes',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        leading: Icon(Icons.event_note, color: AppColors.iconColor),
                      ),
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
