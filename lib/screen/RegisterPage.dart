// import 'package:appfinal/screen/LoginPage.dart';
// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.red,
//                   Colors.purple,
//                 ],
//               ),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.only(top: 100.0, left: 22.0),
//               child: Text(
//                 "Create Your\nAccount",
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           // Form container
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 color: Colors.white,
//               ),
//               height: 650, // ลดความสูงของกล่องสีขาว
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     // Full Name
//                     const TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Full Name',
//                         labelStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                         hintText: 'John Smith',
//                         suffixIcon: Icon(
//                           Icons.check,
//                           color: Colors.green,
//                         ),
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     // Phone or Gmail
//                     const TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Phone or Gmail',
//                         labelStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                         hintText: 'johndoe@gmail.com',
//                         suffixIcon: Icon(
//                           Icons.check,
//                           color: Colors.green,
//                         ),
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     // Password
//                     const TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         labelStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                         suffixIcon: Icon(
//                           Icons.visibility_off,
//                           color: Colors.grey,
//                         ),
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     // Confirm Password
//                     const TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         labelStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                         suffixIcon: Icon(
//                           Icons.visibility_off,
//                           color: Colors.grey,
//                         ),
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Sign Up Button
//                     InkWell(
//                       onTap: () {
//                         // เพิ่มฟังก์ชันหรือการนำทางไปหน้าถัดไปที่นี่
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 const LoginScreen(), // ตัวอย่างเปลี่ยนไปหน้า LoginScreen
//                           ),
//                         );
//                       },
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: 50,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Colors.red,
//                               Colors.purple,
//                             ],
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'SIGN UP',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     // Sign In Text
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't have an account?",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Colors.black,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const LoginScreen(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             " Sign In",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
