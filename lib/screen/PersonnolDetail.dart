import 'package:appfinal/services/FirebaseService%20.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfinal/widget/button/button_manu.dart';
import 'package:appfinal/widget/container_decoration.dart';

class PersonnolDetails extends StatefulWidget {
  const PersonnolDetails({super.key});

  @override
  State<PersonnolDetails> createState() => _PersonnolDetailsState();
}

class _PersonnolDetailsState extends State<PersonnolDetails> {
  final FirebaseService _firebaseService = FirebaseService(); // ✅ ใช้ FirebaseService

  DateTime? selectedDate;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? selectedGender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Please fill out the information completely."),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ✅ บันทึกข้อมูล และไปหน้าถัดไป
  Future<void> _saveUserData() async {
    String height = heightController.text;
    String weight = weightController.text;

    if (selectedGender == null) {
      _showErrorDialog("Please select your gender.");
      return;
    } else if (selectedDate == null) {
      _showErrorDialog("Please select your birthday.");
      return;
    } else if (height.isEmpty) {
      _showErrorDialog("Please enter your height.");
      return;
    } else if (weight.isEmpty) {
      _showErrorDialog("Please enter your weight.");
      return;
    }

    int age = DateTime.now().year - selectedDate!.year;
    String uuid = await _firebaseService.createAndSaveUUID();

    try {
      await FirebaseFirestore.instance.collection('users').doc(uuid).set({
        'uuid': uuid,
        'age': age,
        'birthday': selectedDate?.toIso8601String(),
        'height': double.tryParse(height) ?? 0.0,
        'weight': double.tryParse(weight) ?? 0.0,
        'gender': selectedGender ?? 'Not Specified',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("✅ บันทึกข้อมูลสำเร็จ!");

      // ✅ ไปหน้าถัดไป
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalculateFoodCalories(
            height: height,
            weight: weight,
          ),
        ),
      );
    } catch (e) {
      print("❌ บันทึกข้อมูลล้มเหลว: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary,
                  AppColors.primary.withOpacity(0.7),
                  AppColors.primary.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: 300,
            child: const Center(
              child: Text(
                "Personnol Details",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          ContainerDecoration(
            text: 'Birthday',
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 24, color: AppColors.secondary),
                  const SizedBox(width: 10),
                  Text(
                    selectedDate != null
                        ? '${selectedDate?.toLocal()}'.split(' ')[0]
                        : 'Select your birthday',
                    style:const TextStyle(fontSize: 14, color: AppColors.secondary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ContainerDecoration(
            text: 'Height',
            child: SizedBox(
              width: 200,
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(hintText: 'Enter your height (cm)'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ContainerDecoration(
            text: 'Weight',
            child: SizedBox(
              width: 200,
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(hintText: 'Enter your weight (kg)'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ContainerDecoration(
            text: 'Gender',
            child: DropdownButton<String>(
              value: selectedGender,
              hint: const Text(
                'Select gender',
                style: TextStyle(fontSize: 14),
              ),
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 156,
            padding: const EdgeInsets.all(50),
            child: ElevatedButton(
              onPressed: _saveUserData, // ✅ บันทึกข้อมูลแล้วไปหน้าถัดไป
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: AppColors.background,
                    width: 4,
                  ),
                ),
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
