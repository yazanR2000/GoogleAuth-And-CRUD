import 'package:flutter/material.dart';
import '../user_or_admin.dart' as u;

class UserOrAdmin extends StatelessWidget {
  const UserOrAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      u.UserOrAdmin.isUser = false;
                      Navigator.of(context).pushNamed('/auth');
                    },
                    child: const Text("Admin"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      u.UserOrAdmin.isUser = true;
                      Navigator.of(context).pushNamed('/auth');
                    },
                    child: const Text("User"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
