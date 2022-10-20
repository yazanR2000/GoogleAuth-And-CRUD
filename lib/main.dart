import 'package:auth_providers/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/user_or_admin.dart';
import './screens/category_products.dart';
import './screens/add_new_product.dart';
import './screens/main_admin_control.dart';
import './user_or_admin.dart' as u;
import 'dart:developer';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: u.UserOrAdmin(),
        ),
      ],
      child: MaterialApp(
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
          '/auth': (context) => Login_screen(),
          '/admin': (context) => UserOrAdmin(),
          '/products': (context) => CategoryProducts(),
          '/add_new_product': (context) => AddNewProduct(),
          '/home': (context) => Home(),
          '/main_admin_control': (context) => mainAdminControl(),
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          log("$snapshot");
          if (snapshot.hasData) {
            return Home();
          }
          return Login_screen();
        });
  }
}
