import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../components/token_provider.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final apiUrl = "https://auth-api-jpa9.onrender.com/api/v1/users/login";
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();


  Future<void> verifyLogin() async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailTextController.text,
        "password": passwordTextController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle a successful response, e.g., show a success message or navigate to another screen.
      print(await response.body);

      //store the token
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      if (token != null) {
        Provider.of<TokenProvider>(context, listen: false).setToken(token);
      } else {
        // Handle the case where the token is missing in the response.
        print("Token not found in response");
      }

      //store user email
      final userEmail = emailTextController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(userEmail: userEmail),
      ));
    } else if (response.statusCode == 401) {
      // Unauthorized error, incorrect email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect email or password'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle other error responses
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  // Logo or any other widget
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  // Text
                  Text(
                    "You have been missed!",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Email Text field
                  TextField(
                    controller: emailTextController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Password Text field
                  TextField(
                    controller: passwordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Button to trigger login
                  ElevatedButton(
                    onPressed: verifyLogin,
                    child: Text("Login"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
