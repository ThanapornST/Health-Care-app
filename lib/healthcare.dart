// เป็นหน้าสำหรับเปลี่ยนจอ
import 'package:appfinal/screen/PersonnolDetail.dart';
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:appfinal/widget/button/button_manu.dart';
import 'package:appfinal/widget/intro/swiper_images.dart';
import 'package:flutter/material.dart';

class HealthCares extends StatefulWidget {
  const HealthCares({super.key});

  @override
  State<HealthCares> createState() => _HealthCaresState();
}

class _HealthCaresState extends State<HealthCares> {
  var activeScreen = 'start-screen';

  void openScreen() {
    setState(() {
      activeScreen = 'PersonnolDetails-screen';
    });
  }

  void openSelection() {
    setState(() {
      activeScreen = 'SelectWhatYouWant';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = SwiperImages(openScreen);


    if (activeScreen == 'PersonnolDetails-screen') {
      screenWidget = const PersonnolDetails();
    }

    if (activeScreen == 'SelectWhatYouWant') {
      screenWidget = const CalculateFoodCalories(height: '', weight: '',);
    }

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:
            AppColors.background, 
      ),
      home: Scaffold(
        backgroundColor: AppColors.background, 
        body: Container(
          color: AppColors.background, 
          child: screenWidget,
        ),
      ),
    );
  }
}
