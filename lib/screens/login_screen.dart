import 'package:auth_providers/api/auth/reset_password.dart';
import 'package:auth_providers/screens/user_or_admin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import './signup_Screen.dart';
import 'package:flutter/material.dart';
import '../api/auth/signin_with_google.dart';
import '../api/auth/signin_with_email_and_password.dart';
import '../api/auth/reset_password.dart';
import '../user_or_admin.dart' as u;
import '../widgets/user_or_admin.dart' as s;

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<u.UserOrAdmin>(context, listen: false);

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: _title(),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xffe46b10),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/1.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              s.UserOrAdmin(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await ResetPassword.resetPassword(nameController.text);
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Color(0xffe46b10), fontStyle: FontStyle.italic),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffe46b10)),
                  child: const Text('Login'),
                  onPressed: () async {
                    try {
                      await SigninWithEmailAndPassword.signWithEmailAndPassword(
                        nameController.text,
                        passwordController.text,
                        context,
                        !userProvider.isUser!,
                      );
                    } catch (err) {}
                    // print(nameController.text);
                    // print(passwordController.text);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<u.UserOrAdmin>(
                builder: ((context, value, child) {
                  if (value.isUser!) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              try {
                                await Google.signinWithGoogle();
                              } catch (err) {}
                            },
                            icon: const FaIcon(FontAwesomeIcons.google),
                            label: const Text("Signin with google"),
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                }),
              ),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SignUpPage();
                        },
                      ));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}

Widget _title() {
  return RichText(
    softWrap: false,
    text: TextSpan(
        onEnter: ((event) {
          print("123");
        }),
        text: 'Lt',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
        children: [
          TextSpan(
            text: 'uc Stu',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'dents',
            style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          ),
        ]),
  );
}
