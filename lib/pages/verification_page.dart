import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/button.dart';
import '../components/text_feild.dart';
import 'home_page.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  VerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final apiUrl = "https://auth-api-jpa9.onrender.com/api/v1/users/otp";
  final emailTextController = TextEditingController();
  final otpTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailTextController.text = widget.email; // Pre-fill the email field with the passed email
  }

  Future<void> verifyOtp() async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailTextController.text,
        "otp": otpTextController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Handle a successful response, e.g., show a success message or navigate to another screen.
      print(await response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Otp Verified'),
          duration: Duration(seconds: 2),
        ),
      );
      final userEmail = emailTextController.text;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(userEmail: userEmail),
      ));
    } else {
      // Handle an error response, e.g., show an error message to the user.
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
                    "Verification",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Email Text field
                  MyTextFeild(
                      controller: emailTextController,
                      hintText: "Email",
                      obscureText: false),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextFeild(
                      controller: otpTextController,
                      hintText: "Enter Otp",
                      obscureText: false),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(onTap: verifyOtp, text: "Verify"),
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
                        onTap: () {},
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
