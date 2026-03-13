import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserData(UserModel user) async{
    try{
      await _db.collection('users').doc(user.uid).set(user.toMap());
    } catch(e) {
      debugPrint('Error guardando datos $e');
    }
  }

  Stream<UserModel?> getUserData(String uid) {
    return _db.collection('users').doc(uid).snapshots().map(
      (snapshot) {
        final data = snapshot.data();
        if (data == null) return null;
        return UserModel.fromMap(data, snapshot.id);
      },
    );
  }

  /// Obtiene los datos del usuario una vez (para pantalla de inicio).
  Future<UserModel?> getUserDataOnce(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data();
    if (data == null) return null;
    return UserModel.fromMap(data, doc.id);
  }

  Future<void> updateProfileImage(String uid, String newImagePath) async {
    await _db.collection('users').doc(uid).update({
      'profileImage': newImagePath,
    });
  }

  Future<void> deleteUserData(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
    } catch (e) {
      debugPrint('Error eliminando datos del usuario: $e');
    }
  }
}