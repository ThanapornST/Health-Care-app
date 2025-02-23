import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // สร้าง UUID และบันทึกลง Firestore
  Future<String> createAndSaveUUID() async {
    var uuid = Uuid();
    String newUUID = uuid.v4();

    await _firestore.collection('users').doc(newUUID).set({
      'uuid': newUUID,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return newUUID;
  }
}
