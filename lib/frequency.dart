import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

const String _assetFolder = 'frequency/';

class Frequency extends StatefulWidget {
  @override
  _FrequencyState createState() => _FrequencyState();

  String getLastPlayedFrequency() {
    return _FrequencyState.getLastPlayedFrequency();
  }
}

class _FrequencyState extends State<Frequency> {
  double _tinnitusToneVolume = 3000;
  List<String> savedFrequencies = [];
  String _selectedFrequency = '';
  String _mode = 'Therapy tones (default)';
  bool _isReverse = false;
  late AudioPlayer _player;
  StreamSubscription<Duration>? _positionSubscription;
  bool _isPlaying = false;
  static String _lastPlayedFrequency = '';

  static String getLastPlayedFrequency() {
    return _lastPlayedFrequency;
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    String titleText = _isPlaying
        ? "Playing: $_selectedFrequency"
        : "My Tinnitus Tone: ${_tinnitusToneVolume.toInt()} Hz";
    if (_isPlaying) {
      _mode = 'Playing: $_selectedFrequency';
    } else if (_selectedFrequency.isNotEmpty) {
      _mode = 'Frequency: $_selectedFrequency';
    }

    

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
        title: Text(
          'Tonal Tinnitus Therapy',
          style: TextStyle(
            fontFamily: 'ubuntu',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontFamily: 'ubuntu',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Slider(
                    value: _tinnitusToneVolume,
                    min: 3000,
                    max: 8000,
                    onChanged: (value) {
                      setState(() {
                        _tinnitusToneVolume = (value ~/ 10) * 10;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _playFrequency(_tinnitusToneVolume.toInt());
                        },
                        child: Text('Play'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[500],
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () {
                          _player.pause();
                          _isPlaying = false;
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            savedFrequencies.remove(_selectedFrequency);
                            if (savedFrequencies.isNotEmpty) {
                              _selectedFrequency = savedFrequencies.last;
                            } else {
                              _selectedFrequency = '';
                            }
                          });
                          updateDropdownItems();
                        },
                      ),
                      Switch(
                        value: _isReverse,
                        onChanged: (value) {
                          setState(() {
                            _isReverse = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (savedFrequencies.length >= 6) {
                        savedFrequencies.removeAt(0);
                      }
                      savedFrequencies.add('${_tinnitusToneVolume.toInt()} Hz');
                      updateDropdownItems();
                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[500],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField(
                    value: _selectedFrequency,
                    items: getDropdownItems(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      filled: true,
                      fillColor: Colors.teal[50],
                    ),
                    style: TextStyle(
                      color: Colors.teal[700],
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedFrequency = value as String;
                        _tinnitusToneVolume =double.parse(_selectedFrequency.split(' ')[0]);
                      });
                      _mode = 'Frequency: $_selectedFrequency';
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String frequency in savedFrequencies.reversed) {
      items.add(DropdownMenuItem(
        child: Text(frequency),
        value: frequency,
      ));
    }
    return items;
  }

  void updateDropdownItems() {
    setState(() {
      if (savedFrequencies.isNotEmpty) {
        _selectedFrequency = savedFrequencies.last;
        _tinnitusToneVolume = double.parse(_selectedFrequency.split(' ')[0]);
      }
    });
  }

  Future<void> _playFrequency(int frequency) async {
    final filePath = "${_assetFolder}$frequency.mp3";
    try {
      await _player.setAsset(filePath);
      await _player.play();

      setState(() {
        _isPlaying = true;
        _lastPlayedFrequency = "$frequency Hz";
      });

      _positionSubscription = _player.positionStream.listen((duration) async {
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void _pausePlayback() {
    _player.pause();
    _positionSubscription?.cancel();
  }
}