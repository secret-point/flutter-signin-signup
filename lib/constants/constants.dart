import 'package:flutter/material.dart';

abstract class Constants {
  static const String apiUrl =
      "https://user-authentication-app.onrender.com/api";
  static const String aesKey = "5432109876543210";
  static const String IV = "0123456789012345";
  static const apiHeader = {
    "Content-type": "application/json",
    "Accept": "application/json",
  };

  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static const errorColor = Color(0xFFF53636);

  static const double defaultPadding = 16.0;
}
