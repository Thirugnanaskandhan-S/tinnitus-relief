import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'package:flutter_application_1/main.dart'; // Import the math library for random number generation

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Registration',
      home: RegistrationPage(),
    );
  }
}

final TextEditingController didController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('Students');

  String _generatedDid = ""; // Store the generated DID

  @override
  void initState() {
    super.initState();
    _generateRandomDid(); // Generate a random DID on initialization
  }

  Future<void> _generateRandomDid() async {
    // Generate a random 9-digit number
    int randomNumber = Random().nextInt(900000000) + 100000000; // Ensure a 9-digit number
    _generatedDid = "DID" + randomNumber.toString(); // Concatenate with "DID" prefix
    didController.text = _generatedDid; // Set the generated DID in the text field
  }

  Future<void> _registerUser() async {
    try {
      // Create a new user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: didController.text.trim() + "@example.com",
        password: "password", // Set a default password or generate one securely.
      );

      // Store additional data in Firebase Realtime Database
      String userId = userCredential.user!.uid;
      _database.child(didController.text).child(nameController.text).set({
        "EMG": {
          "2023-11-23 14:19:57": "80"
        },
        "Galvonic": {
          "2003-11-23 14:20:57": "2.35"
        },
        "Pulse": {
          "2003-11-23 14:20:57": "2.35"
        },
        "overall_category": {
          "category": "Neutral"
        },
        "predictions": {
          "2003-11-23 14:20:57": "tinnitus",
        }
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomNavigationBar(),));
    } catch (e) {
      print("Error during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         
    mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: didController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Enter DID Number',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Enter Name',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () => _registerUser(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  'Create',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
