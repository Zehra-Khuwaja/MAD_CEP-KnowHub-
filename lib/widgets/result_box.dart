import 'package:flutter/material.dart';
import 'package:my_app/models/firebase_auth.dart';
import 'package:my_app/screens/login.dart';
import '../constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  }) : super(key: key);
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    Future<void> _signOut(BuildContext context) async {
      try {
        await AuthService.signOut();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(), // Replace with your login page
          ),
        );
      } catch (e) {
        print('Sign-out failed: $e');
      }
    }

    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: EdgeInsets.all(60.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Result',
                style: TextStyle(color: neutral, fontSize: 22.0),
              ),
              const SizedBox(height: 20.0),
              CircleAvatar(
                child: Text(
                  '$result/$questionLength',
                  style: TextStyle(fontSize: 30.0),
                ),
                radius: 70.0,
                backgroundColor: result == questionLength / 2
                    ? Colors.yellow
                    : result < questionLength / 2
                        ? incorrect
                        : correct,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                result == questionLength / 2
                    ? 'Almost There'
                    : result < questionLength / 2
                        ? 'Try Again'
                        : 'Great!',
                style: const TextStyle(color: neutral),
              ),
              const SizedBox(height: 25.0),
              GestureDetector(
                onTap: onPressed,
                child: const Text(
                  'Start Over',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _signOut(context);
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              )
            ]),
      ),
    );
  }
}
