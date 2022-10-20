import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../user_or_admin.dart';
import 'package:flutter/material.dart';

class SignupWithEmailAndPassword {
  static Future signupWithEmailAndPassword(
      String email, String password, BuildContext ctx,bool isAdmin) async {
    try {
      if (isAdmin) {
        await FirebaseFirestore.instance
            .collection("Requests")
            .add({"email": email, "password": password});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text("Please wait until the main admin accept you"),
          ),
        );
        return;
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text(err.toString()),
        ),
      );
      throw err;
    }
  }
}
