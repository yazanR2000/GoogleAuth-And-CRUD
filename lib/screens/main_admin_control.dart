import 'package:auth_providers/api/auth/accept_admins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class mainAdminControl extends StatefulWidget {
  const mainAdminControl({super.key});

  @override
  State<mainAdminControl> createState() => _mainAdminControlState();
}

class _mainAdminControlState extends State<mainAdminControl> {
  
  final CollectionReference adminRequests =
      FirebaseFirestore.instance.collection('Requests');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: adminRequests.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['email']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                MainAdmin.approvement(documentSnapshot);
                              },
                              icon: const Icon(Icons.check),
                            ),
                            IconButton(
                              onPressed: () {
                                MainAdmin.disApprovment(documentSnapshot);
                              },
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
