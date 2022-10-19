import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google {
  static Future signinWithGoogle() async {
    try {
      final googleSigIn = GoogleSignIn();
      final googleUser = await googleSigIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User = await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (err) {
      throw err;
    }
  }
}
