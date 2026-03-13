import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Contraseña usada en el último inicio de sesión (solo en memoria, para mostrarla en perfil).
  static String? lastLoginPassword;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signUp(String email, String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
    } catch(e) {
      rethrow;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      lastLoginPassword = password;
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    lastLoginPassword = null;
    await _auth.signOut();
  }
}