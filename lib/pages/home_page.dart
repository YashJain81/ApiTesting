import 'package:apitesting/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/token_provider.dart';


class HomePage extends StatelessWidget {

  final String userEmail;

  HomePage({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logged in as: $userEmail",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Log out and navigate back to the login page
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginOrRegister(),
                ));
              },
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
