import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user_or_admin.dart' as u;
class UserOrAdmin extends StatefulWidget {
  const UserOrAdmin({super.key});

  @override
  State<UserOrAdmin> createState() => _UserOrAdminState();
}

class _UserOrAdminState extends State<UserOrAdmin> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<u.UserOrAdmin>(context,listen: false);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                 userProvider.isUser! ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                userProvider.isUser = true;
              });
            },
            child: const Text("User"),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  !userProvider.isUser! ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                userProvider.isUser = false;
              });
            },
            child: const Text("Admin"),
          ),
        ),
      ],
    );
  }
}
