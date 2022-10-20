import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_or_admin.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
 
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserOrAdmin>(context,listen: false);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signOut();
            } catch (err) {
              print(err);
            }
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
        title: Image.asset(
          "images/shop_logo.png",
          height: 30,
          width: 40,
        ),
        actions: [
          if (user!.email == 'admin@admin.com')
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/main_admin_control');
              },
              child: const Text("Control admins"),
            ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.docs;
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                final Products products = Products.getInstance();
                products.collection = data[index]['name'];
                Navigator.of(context).pushNamed('/products');
              },
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  //color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(data[index]['imageUrl']),
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 300,
                  child: Text(
                    data[index]['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
