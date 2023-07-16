import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soultrain/utils/utility.dart';
import 'package:http/http.dart';

import 'package:soultrain/components/already_have_an_account_acheck.dart';
import 'package:soultrain/constants/constants.dart';
import 'package:soultrain/ui/login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String notification = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
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
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: Constants.kPrimaryColor,
            controller: usernameController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Username",
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
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
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
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Constants.kPrimaryColor,
              controller: passwordConfirmController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please re-enter password';
                }

                if (passwordConfirmController.text != passwordController.text) {
                  return "Password does not match";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                final uri = Uri.parse('${Constants.apiUrl}/signup');
                final body = {
                  "username": usernameController.text,
                  "email": emailController.text,
                  "password": Utility.encrypt(passwordController.text)
                };
                Response response = await post(uri,
                    headers: Constants.apiHeader, body: jsonEncode(body));
                if (response.statusCode == 200) {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                } else {
                  final message = jsonDecode(response.body.toString());
                  setState(() {
                    notification = message["error"]!.toString();
                  });
                }
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: Constants.defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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
