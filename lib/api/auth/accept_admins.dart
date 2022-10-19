import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainAdmin {
  final List<Request> _requests = [];

  Future approvement(QueryDocumentSnapshot<Map<String, dynamic>> user) async {
    try {
      final UserCredential userAdmin =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user['email'],
        password: user['password'],
      );
      await FirebaseFirestore.instance.collection("Users").add({
        "email": user['email'],
      });
      await FirebaseFirestore.instance
          .collection("Requests")
          .doc(user.id)
          .delete();
    } catch (err) {
      throw err;
    }
  }

  Future disApprovment(QueryDocumentSnapshot<Map<String, dynamic>> user) async {
    try{
      await FirebaseFirestore.instance.collection("Requests").doc(user.id).delete();
    }catch(err){
      throw err;
    }
  }

  void addRequest(List<QueryDocumentSnapshot<Map<String, dynamic>>> requests) {
    requests.forEach((element) {
      _requests.add(
        Request(element),
      );
    });
  }
}

class Request {
  final QueryDocumentSnapshot<Map<String, dynamic>> _request;
  Request(this._request);
}
