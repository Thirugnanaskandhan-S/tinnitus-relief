import 'package:flutter/material.dart';

class StagesOfHabituationPage extends StatefulWidget {
  @override
  _StagesOfHabituationPageState createState() => _StagesOfHabituationPageState();
}

class _StagesOfHabituationPageState extends State<StagesOfHabituationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stages of Habituation', 
        style: TextStyle(
          fontFamily: 'ubuntu',
          fontWeight: FontWeight.w600,
          fontSize: 10,
          letterSpacing: 1.0
        ) ,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Stage 1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You were aware of tinnitus all the time. You could only focus for a few minutes, often worried or felt down and if your sleep was affected it was severe.',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.white), 
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
              },
              child: Text(
                'Tap to continue',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
