import 'package:apitesting/auth/login_or_register.dart';
import 'package:apitesting/pages/home_page.dart';
import 'package:apitesting/pages/login_page.dart';
import 'package:apitesting/pages/register_page.dart';
import 'package:apitesting/pages/verification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/token_provider.dart';


void main() {
  runApp(
    // Wrap your app with ChangeNotifierProvider for TokenProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TokenProvider()),
      ],
      child: MaterialApp(
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginOrRegister();
  }
}