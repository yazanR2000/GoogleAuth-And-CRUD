import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword {
  static Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (err) {
      throw err;
    }
  }
}
