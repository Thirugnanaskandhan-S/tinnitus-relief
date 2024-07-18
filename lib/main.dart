import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/frequency.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/registration.dart';
import 'package:flutter_application_1/sounds.dart';
import 'package:flutter_application_1/welcome.dart';
// ignore: unused_import
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_application_1/voice.dart';
import 'package:just_audio/just_audio.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

final Map<String, String> musicPaths = {
  //color
  "Blue": "musics/Blue.mp3",
  "White": "musics/White.mp3",
  "Green": "musics/Green.mp3",
  "Pink": "musics/Pink.mp3",
  "Brown": "musics/Brown.mp3",
  //nature
  "Ocean": "musics/Ocean.mp3",
  "Rain": "musics/Rain.mp3",
  "River": "musics/River.mp3",
  "ThunderStrom": "musics/ThunderStrom.mp3",
  "Forest": "musics/Forest.mp3",
  //Binural
  "Alpha": "musics/Alpha.mp3",
  "Beta": "musics/Beta.mp3",
  "Gamma": "musics/Gamma.mp3",
  "Delta": "musics/Delta.mp3",
  "Theta": "musics/Theta.mp3",
  //traffic
  "Aircraft": "musics/Aircraft.mp3",
  "Bus": "musics/Bus.mp3",
  "Car": "musics/Car.mp3",
  "Train": "musics/Train.mp3",
  "Underground": "musics/Underground.mp3"
};

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  late AudioPlayer player;
  int currentIndex = 0;
  String lastPlayedFrequency = '';
  late List<Widget> _children;

  // State variable to track play/pause state
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _children = [
      home(did: didController.text.trim(), name: nameController.text.trim()),
      Frequency(),
      Myvoice(),
      sounds(player: player, musicPaths: musicPaths),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Function to update the last played frequency
  void updateLastPlayedFrequency(String frequency) {
    setState(() {
      lastPlayedFrequency = frequency;
    });
  }

  // Function to handle play/pause button tap
  void handlePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        // Play audio
        playFrequency(lastPlayedFrequency);
      } else {
        player.pause(); // Pause audio
      }
    });
  }

  void playFrequency(String frequency) {
  // Remove spaces and "Hz" from the frequency
  String sanitizedFrequency = frequency.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

  // Remove trailing "Hz"
  sanitizedFrequency = sanitizedFrequency.replaceAll('Hz', '');

  String filePath = "frequency/$sanitizedFrequency.mp3";
  player.setAsset(filePath);
  player.play();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _children[currentIndex],
          Positioned(
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Color.fromRGBO(1, 152, 117, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Play/pause button with dynamic icon
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                    color: Colors.black,
                    onPressed: handlePlayPause,
                  ),
                  Text(
                    "Last Played Frequency",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    lastPlayedFrequency,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(1, 152, 117, 1),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        onTap: (index) {
          onTabTapped(index);
          if (index == 1) {
            Frequency frequencyWidget = _children[1] as Frequency;
            updateLastPlayedFrequency(frequencyWidget.getLastPlayedFrequency());
          }
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Frequency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.read_more),
            label: 'Voice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Sounds',
          ),
        ],
      ),
    );
  }
}