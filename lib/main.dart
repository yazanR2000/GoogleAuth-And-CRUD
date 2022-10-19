import 'package:auth_providers/screens/home.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/home.dart';
import './screens/user_or_admin.dart';
import './screens/category_products.dart';
import './screens/add_new_product.dart';
import './screens/home.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.black, fontFamily: "Roboto", fontSize: 25),
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xff483838),
          ),
        ),
      ),
      home: MyApp(),
      routes: {
        '/auth' :(context) => Login_screen(),
        '/admin' :(context) => UserOrAdmin(),
        '/products': (context) => CategoryProducts(),
        '/add_new_product': (context) => AddNewProduct(),
        '/home' :(context) => Home(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserOrAdmin();
  }
}
