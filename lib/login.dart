import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final databaseRef = FirebaseDatabase.instance.reference();
  final didNumberController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> checkDID(String didNumber) async {
    try {
      DatabaseEvent event =
          await databaseRef.child('Students/$didNumber').once();
      DatabaseEvent eventname =
          await databaseRef.child('Students/$didNumber/').once();

      if (event.snapshot?.value != null && eventname.snapshot?.value != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Login Successful',
          ),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MyBottomNavigationBar(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Invalid DID number. Please recheck the number.',
          ),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      print('Failed to login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      appBar: AppBar(
        title: Text(
          'Login',
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
              controller: didNumberController,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                                border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                hintText: 'Enter DID Number',
                hintStyle:TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
                 style: TextStyle(
                color: Colors.white
              ),
              controller: nameController,
              decoration:  InputDecoration(
                border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                hintText: 'Enter Name',
                   hintStyle:TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () => checkDID(didNumberController.text),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                child: Text('Login',
                style: TextStyle(
                  fontSize: 15
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}