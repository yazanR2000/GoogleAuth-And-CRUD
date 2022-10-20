import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainAdmin {
  static Future approvement(DocumentSnapshot? documentSnapshot) async {
    try {
      final UserCredential userAdmin =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: documentSnapshot!['email'],
        password: documentSnapshot['password'],
      );
      await FirebaseFirestore.instance.collection("Admins").add({
        "email": documentSnapshot['email'],
      });
      await FirebaseFirestore.instance
          .collection("Requests")
          .doc(documentSnapshot.id)
          .delete();
    } catch (err) {
      throw err;
    }
  }

  static Future disApprovment(DocumentSnapshot? documentSnapshot) async {
    try {
      await FirebaseFirestore.instance
          .collection("Requests")
          .doc(documentSnapshot!.id)
          .delete();
    } catch (err) {
      throw err;
    }
  }
}
