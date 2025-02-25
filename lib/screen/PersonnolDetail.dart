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
  final FirebaseService _firebaseService = FirebaseService();

  DateTime? selectedDate;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? selectedGender;

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Incomplete Information"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _saveUserData() async {
    String height = heightController.text.trim();
    String weight = weightController.text.trim();

    if (selectedGender == null) {
      _showErrorDialog("Please select your gender.");
      return;
    } else if (selectedDate == null) {
      _showErrorDialog("Please select your birthday.");
      return;
    } else if (height.isEmpty || double.tryParse(height) == null) {
      _showErrorDialog("Please enter a valid height.");
      return;
    } else if (weight.isEmpty || double.tryParse(weight) == null) {
      _showErrorDialog("Please enter a valid weight.");
      return;
    }

    int age = DateTime.now().year - selectedDate!.year;
    String uuid = await _firebaseService.createAndSaveUUID();

    try {
      await FirebaseFirestore.instance.collection('users').doc(uuid).set({
        'uuid': uuid,
        'age': age,
        'birthday': selectedDate?.toIso8601String(),
        'height': double.parse(height),
        'weight': double.parse(weight),
        'gender': selectedGender!,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("✅ Data saved successfully!");

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
      print("❌ Failed to save data: $e");
      _showErrorDialog("An error occurred while saving your data. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // ✅ เพิ่ม SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0), // ✅ เพิ่ม padding เพื่อป้องกันเนื้อหาถูกบัง
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildDatePicker(),
              const SizedBox(height: 20),
              _buildTextField('Height', heightController, 'Enter your height (cm)'),
              const SizedBox(height: 20),
              _buildTextField('Weight', weightController, 'Enter your weight (kg)'),
              const SizedBox(height: 20),
              _buildGenderDropdown(),
              const SizedBox(height: 30),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
          "Personal Details",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ContainerDecoration(
      text: 'Birthday',
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 24, color: AppColors.secondary),
            const SizedBox(width: 10),
            Text(
              selectedDate != null
                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                  : 'Select your birthday',
              style: const TextStyle(fontSize: 14, color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint) {
    return ContainerDecoration(
      text: label,
      child: SizedBox(
        width: 200,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
          decoration: InputDecoration(hintText: hint),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return ContainerDecoration(
      text: 'Gender',
      child: DropdownButton<String>(
        value: selectedGender,
        hint: const Text(
          'Select gender',
          style: TextStyle(fontSize: 14),
        ),
        items: ['Male', 'Female', 'Other']
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue;
          });
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
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
        onPressed: _saveUserData,
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
    );
  }
}
