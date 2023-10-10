// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/models/firebase_auth.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final _formkey = GlobalKey<FormState>();
    final AuthService authService = AuthService();
    TextEditingController emailCont = TextEditingController();
    TextEditingController passCont = TextEditingController();

    signIn() async {
      try {
        final User? user = await authService.signIn(
          emailCont.text,
          passCont.text,
        );

        if (user != null) {
          final userDetails = await authService.getUserDetails(user.email!);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          // Handle the case where the user does not exist or credentials are incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Invalid credentials. Please check your email and password."),
              backgroundColor: Colors.deepPurpleAccent,
            ),
          );
        }
      } catch (e) {
        // Handle other exceptions (e.g., network issues)
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred. Please try again later."),
            backgroundColor: Colors.deepPurpleAccent,
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        color: background,
        child: Center(
          child: Stack(children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                width:
                    screenWidth < 600 ? screenWidth : 600, // Responsive width
                child: Form(
                  key: _formkey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/logo.png', // Replace with your logo image asset
                        width: 200, // Adjust the width as needed
                        height: 200, // Adjust the height as needed
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailCont,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          filled: true, // Set to true to fill the background
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some value';
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: passCont,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          filled: true, // Set to true to fill the background
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some value';
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                signIn();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 16), // Button padding
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  background, // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 16), // Button padding
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  background, // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
