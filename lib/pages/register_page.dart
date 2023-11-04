import 'dart:convert';
import 'package:apitesting/pages/verification_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final apiUrl = "https://auth-api-jpa9.onrender.com/api/v1/users/register";
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final nameTextController = TextEditingController();

  // Future<void> sendPostRequest() async {
  //   var response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "name": nameTextController.text,
  //       "email": emailTextController.text,
  //       "password": passwordTextController.text,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Handle a successful response, e.g., show a success message or navigate to another screen.
  //     print("Before registering.....");
  //     print(await response.body);
  //     print("Registered......");
  //
  //     // Navigate to the VerificationPage or any other screen you want.
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //       print("Inside navigator .....");
  //       return VerificationPage();
  //     }));
  //   } else {
  //     // Handle an error response, e.g., show an error message to the user.
  //     print(response.reasonPhrase);
  //   }
  // }

  Future<void> sendPostRequest() async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": nameTextController.text,
        "email": emailTextController.text,
        "password": passwordTextController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("POST request successful!");
      print("Response body: ${response.body}");

      // Navigate to the VerificationPage
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        print("Navigating to VerificationPage...");
        return VerificationPage(email: emailTextController.text);
      }));
    } else {
      print("POST request failed with status code ${response.statusCode}");
      print("Response reason: ${response.reasonPhrase}");
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
                    "Welcome!",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Name Text field
                  TextField(
                    controller: nameTextController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                  // Confirm Password Text field
                  TextField(
                    controller: confirmPasswordTextController,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Button to trigger registration
                  ElevatedButton(
                    onPressed: sendPostRequest,
                    child: Text("Sign Up"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login here",
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
