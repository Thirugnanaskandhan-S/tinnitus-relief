import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/registration.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromRGBO(21, 34, 56, 1),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 70,vertical: 20)
                ),
              ),
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            }, child: const Text("Login")),
            ElevatedButton(
               style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 70,vertical: 20)
                ),
              ),
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage(),));
            }, child: const Text("Register"))
          ],
        ),
      ),
    );
  }
}

