// ignore_for_file: unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/firebase_auth.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  CollectionReference doctors = FirebaseFirestore.instance.collection("users");

  signUp() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCont.text,
        password: passCont.text,
      );

      if (userCredential.user != null) {
        // Registration successful, proceed with saving data to Firestore
        doctors.add({
          "name": nameCont.text,
          "email": emailCont.text,
          "password": passCont.text,
        });

        final userDetails = {
          "name": nameCont.text,
          "email": emailCont.text,
          "password": passCont.text,
        };

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Email is already in use. Please use a different email."),
              backgroundColor: Colors.deepPurpleAccent,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration failed. Please try again."),
              backgroundColor: Colors.deepPurpleAccent,
            ),
          );
        }
      } else {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3464), // Background color set here
      body: Center(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: nameCont,
                    decoration: InputDecoration(
                      labelText: 'Name', // Label text for Name field
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.white, // Icon color set to white
                      ),
                      filled: true, // Set to true to fill the background
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.grey, // Label text color set to grey
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color set to white
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailCont,
                    decoration: InputDecoration(
                      labelText: 'Email', // Label text for Email field
                      icon: Icon(
                        Icons.email,
                        color: Colors.white, // Icon color set to white
                      ),
                      filled: true, // Set to true to fill the background
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.grey, // Label text color set to grey
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color set to white
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passCont,
                    decoration: InputDecoration(
                      labelText: 'Password', // Label text for Password field
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white, // Icon color set to white
                      ),
                      filled: true, // Set to true to fill the background
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.grey, // Label text color set to grey
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color set to white
                        ),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16), // Button padding
                      backgroundColor: Colors.white,
                      foregroundColor:
                          Colors.black, // Button text color set to white
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      signUp();
    }
  }
}
