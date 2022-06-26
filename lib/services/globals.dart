import 'package:flutter/material.dart';

const String baseURL = "http://172.30.50.12:8000/api/"; //emulator localhost
const Map<String, String> headers = {"Content-Type": "application/json"};
const String URL = 'http://192.168.1.103:8000/';

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}
