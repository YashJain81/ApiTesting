import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier {
  String? token;

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }
}
