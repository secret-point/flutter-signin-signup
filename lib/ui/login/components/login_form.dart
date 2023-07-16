import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soultrain/ui/home/home_screen.dart';
import 'package:soultrain/utils/utility.dart';
import 'package:http/http.dart';

import 'package:soultrain/components/already_have_an_account_acheck.dart';
import 'package:soultrain/constants/constants.dart';
import 'package:soultrain/ui/signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String notification = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Constants.defaultPadding),
              child: RichText(
                  text: TextSpan(
                      text: notification,
                      style: const TextStyle(color: Constants.errorColor)))),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Constants.kPrimaryColor,
            controller: emailController,
            validator: (String? value) {
              if (value == null ||
                  !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                return 'Please enter a valid Email';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Constants.defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Constants.kPrimaryColor,
              controller: passwordController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final navigator = Navigator.of(context);
                  final body = {
                    "email": emailController.text,
                    "password": Utility.encrypt(passwordController.text)
                  };
                  final uri = Uri.parse('${Constants.apiUrl}/login');

                  Response response = await post(uri,
                      headers: Constants.apiHeader, body: jsonEncode(body));

                  if (response.statusCode == 200) {
                    navigator.push(MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ));
                  } else {
                    final message = jsonDecode(response.body.toString());
                    setState(() {
                      notification = message["error"]!.toString();
                    });
                  }
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
