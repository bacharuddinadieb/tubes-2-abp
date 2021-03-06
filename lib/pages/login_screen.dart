// import 'dart:convert';

import 'dart:convert';

import 'package:abp_tubes_2/pages/register_screen.dart';
import 'package:abp_tubes_2/tubes_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

// import '../Services/auth_services.dart';
// import '../Services/globals.dart';
import '../Services/globals.dart';
import '../rounded_button.dart';
import '../services/auth_service.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

// import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const TubesBottomNavBar(),
            ));
      } else {
        // ignore: use_build_context_synchronously
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/login.jpg',
                  height: 250,
                  width: 250,
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  btnText: 'LOG IN',
                  onBtnPressed: () => loginPressed(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegisterScreen(),
                        ));
                  },
                  child: const Text("Register"),
                )
              ],
            ),
          ),
        ));
  }
}
