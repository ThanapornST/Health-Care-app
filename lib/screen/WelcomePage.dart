// import 'package:appfinal/screen/LoginPage.dart';
// import 'package:appfinal/screen/RegisterPage.dart';
// import 'package:flutter/material.dart';

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.red,
//               Colors.purple,
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center, // จัดให้เนื้อหาอยู่ตรงกลางในแนวตั้ง
//           crossAxisAlignment:
//               CrossAxisAlignment.center, // จัดให้อยู่ตรงกลางในแนวนอน
//           children: [
//             // Logo
//             Image.network(
//               'https://i.pinimg.com/736x/26/aa/57/26aa57ca0156ad6c573832acb4e8096f.jpg',
//               height: 80,
//               width: 80,
//             ),
//             const SizedBox(height: 20),
//             // Welcome Back text
//             const Text(
//               'Welcome Back',
//               style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 40),
//             // Sign In button
//             Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LoginScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(
//                         0, 255, 255, 255), // สีพื้นหลังของปุ่ม
//                     foregroundColor: Colors.black, // สีข้อความและไอคอน
//                     fixedSize: const Size(300, 50), // กำหนดขนาดปุ่ม
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(30), // ทำให้ปุ่มมีมุมโค้งมน
//                       side: const BorderSide(color: Colors.black), // สีเส้นขอบ
//                     ),
//                   ),
//                   child: const Text(
//                     'SIGN IN',
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RegisterScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white, // สีพื้นหลังของปุ่ม
//                     foregroundColor: Colors.black, // สีข้อความและไอคอน
//                     fixedSize: const Size(300, 50), // กำหนดขนาดปุ่ม
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(30), // ทำให้ปุ่มมีมุมโค้งมน
//                       side: const BorderSide(color: Colors.black), // สีเส้นขอบ
//                     ),
//                   ),
//                   child: const Text(
//                     'SIGN UP',
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
