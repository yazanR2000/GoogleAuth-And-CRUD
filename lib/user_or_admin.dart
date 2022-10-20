import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class UserOrAdmin with ChangeNotifier {
   bool? _isUser = true;
   User? _currentUser;

   bool? get isUser => _isUser;

   set isUser(bool? value) {
    _isUser = value;
    notifyListeners();
  }

   set currentUser(User? value){
    _currentUser = value;
  }

   User? get currentUser => _currentUser;
}