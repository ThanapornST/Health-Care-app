import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyCZ4GECnSPbxDIpNayZXVPE5R8XrOMDeZY"; // 🔥 ใส่ API Key ที่ได้จาก Google AI Studio
  static const String apiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=$apiKey"; // ✅ ใช้ gemini-1.5-pro

  // 🔹 ฟังก์ชันขอคำแนะนำสุขภาพ
  static Future<String> getHealthAdvice(int age, String gender, double weight, double height, String goal) async {
    final Map<String, dynamic> requestBody = {
      "contents": [
        {
          "role": "user",  // ✅ บอกว่าเป็น input ของผู้ใช้
          "parts": [
            {
              "text": "ฉันอายุ $age ปี เพศ $gender น้ำหนัก $weight กก. ส่วนสูง $height ซม. เป้าหมายของฉันคือ $goal "
                      "ช่วยแนะนำอาหารและการออกกำลังกายที่เหมาะสมในรูปแบบที่อ่านง่ายและแบ่งเป็นหมวดหมู่ให้หน่อย"
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.7,
        "maxOutputTokens": 800, // ✅ เพิ่มจำนวนคำที่สามารถตอบได้
        "topP": 0.9,
        "topK": 40
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data["candidates"] != null && data["candidates"].isNotEmpty) {
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        return "❌ ไม่สามารถดึงข้อมูลคำแนะนำสุขภาพได้";
      }
    } else {
      throw Exception("❌ Error: ${response.statusCode} - ${response.body}");
    }
  }
}
