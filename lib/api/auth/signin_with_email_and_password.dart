import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../user_or_admin.dart';
import 'package:flutter/material.dart';

class SigninWithEmailAndPassword {
  static Future signWithEmailAndPassword(
      String email, String password, BuildContext ctx,bool isAdmin) async {
    try {
      if (isAdmin) {
        final db = FirebaseFirestore.instance;
        db.collection("Admins").get().then((querySnapshot) async {
          final admins = querySnapshot.docs;
          int i = 0;
          for (; i < admins.length; i++) {
            if (admins[i]['email'] == email) {
              break;
            }
          }
          if (i == admins.length) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "User not found",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }else{
            await _signin(email,password);
            
          }
        });
      } else {
        await _signin(email, password);
        
      }
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            err.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      throw err;
    }
  }

  static Future _signin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (err) {
      throw err;
    }
  }
}
