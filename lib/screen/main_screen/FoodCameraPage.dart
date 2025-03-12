// import 'package:flutter/material.dart';

// class FakeFoodCameraPage extends StatefulWidget {
//   @override
//   _FakeFoodCameraPageState createState() => _FakeFoodCameraPageState();
// }

// class _FakeFoodCameraPageState extends State<FakeFoodCameraPage> {
//   bool _hasTakenPicture = false; // เช็คว่ากดถ่ายรูปหรือยัง

//   void _fakeTakePicture() {
//     setState(() {
//       _hasTakenPicture = true; // เปลี่ยนสถานะเป็นถ่ายรูปแล้ว
//     });

//     // แสดงผลลัพธ์ว่าเป็น "อีแคล"
//     _showResultDialog("อีแคล");
//   }

//   void _showResultDialog(String result) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('ผลลัพธ์จาก AI'),
//         content: Text('อาหารนี้คือ: $result'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // ปิด Dialog
//               setState(() {
//                 _hasTakenPicture = false; // รีเซ็ตกลับไปหน้าเดิม
//               });
//             },
//             child: Text('ตกลง'),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ถ่ายรูปอาหาร (จำลอง)'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _hasTakenPicture
//                 ? Column(
//                     children: [
//                       Image.network(
//                         'https://cdn.pixabay.com/photo/2017/07/16/10/43/eclair-2501976_1280.jpg', // รูปตัวอย่างของ "อีแคล"
//                         height: 250,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'อาหาร: อีแคล',
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   )
//                 : Icon(
//                     Icons.fastfood,
//                     size: 150,
//                     color: Colors.grey,
//                   ),
//             SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: _fakeTakePicture,
//               icon: Icon(Icons.camera_alt),
//               label: Text('ถ่ายรูปอาหาร (จำลอง)'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 textStyle: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
