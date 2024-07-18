import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  runApp(Myvoice());
}

class Myvoice extends StatelessWidget {
  final FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News and Updates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: voice(tts: tts),
    );
  }
}

class voice extends StatefulWidget {
  final FlutterTts tts;

  const voice({required this.tts});

  @override
  _voiceState createState() => _voiceState();
}

class _voiceState extends State<voice> {
  final _newsContent = {
    'Sports':
        'The world of sports is buzzing with excitement right now, so lets dive into some of the hottest headlines: Cricket: IPL Auction 2024: Mitchell Starc shattered records and became the most expensive player in IPL history, fetching a whopping ₹24.75 crore from Kolkata Knight Riders. Uncapped players like Sameer Rizvi and Kushagra Sharma also hit jackpots with surprising bids. Follow the drama as teams build their squads for the upcoming season. India vs. South Africa ODI: South Africa cruised to an 8-wicket victory in the 2nd ODI, thanks to a century from Dean Elgar and crucial knocks from Rassie van der Dussen and Heinrich Klaasen. India young gun Sai Sudharsan impressed with a gritty 62 on a tough pitch.',
    'Politics':
       "Indian politics is currently bubbling with several major developments, so lets take a look at the latest headlines: Parliamentary turmoil:  Unprecedented suspensions: Over 78 opposition MPs, including Congress leader Adhir Ranjan Chowdhury, were suspended from Parliament in a historic move, sparking outrage and accusations of a dictatorial government. This suspension includes 40 MPs from the Lok Sabha and 38 from the Rajya Sabha. Congress forms alliance committee: Amidst the tension, the Congress party has formed a five-member committee to strategize and manage alliances for the upcoming 2024 Lok Sabha elections.INDIA bloc meeting: Opposition parties under the banner of INDIA (Indian National Democratic Alliance) are holding their fourth meeting today to discuss seat-sharing arrangements and possibly the opposition candidate for Prime Minister. However, a final decision on the PM face remains elusive.",
    'Current Affairs':
        "Chandrayaan-3 Launch Date Announced: India's ambitious third lunar mission, Chandrayaan-3, is now scheduled to launch in May 2024. The mission aims to land a rover on the lunar surface and conduct scientific research. Lightest Bullet Train Unveiled: Indian Railways unveiled the Tejas Light, the lightest and fastest train ever built in India. It is slated to operate on the Delhi-Lucknow route and promises faster travel times and improved passenger comfort. First Genetically Modified Mustard Approved: India approved the commercial cultivation of the country's first genetically modified (GM) mustard variety, DMH 11. This is expected to boost mustard production and reduce India's dependence on imported edible oils. India's Growth Forecast: The International Monetary Fund (IMF) has revised India's GDP growth forecast for 2023-24 upwards to 6.9%, making it the fastest-growing major economy in the world."
  };

  bool isSpeechPlaying = false;

  _speakContent(String content) {
    widget.tts.setSpeechRate(0.5);
    widget.tts.speak(content).then((value) {
      print('Speech completed');
      setState(() {
        isSpeechPlaying = false;
      });
    });
  }

  void _stopSpeech() {
    if (isSpeechPlaying) {
      widget.tts.stop();
      setState(() {
        isSpeechPlaying = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.tts.setLanguage('en-US');
  }

  @override
  void dispose() {
    widget.tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isSpeechPlaying ? Colors.blue : const Color.fromRGBO(21, 34, 56, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
        title: Text(
          'News and Updates',
          style: TextStyle(
            fontFamily: 'ubuntu',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
       // onTap: _stopSpeech,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: _newsContent.length,
          itemBuilder: (context, index) {
            String category = _newsContent.keys.elementAt(index);
            String content = _newsContent.values.elementAt(index);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlainWidgetScreen(
                      content: content,
                    ),
                  ),
                );
                _speakContent(category);
                _speakContent(content.split('\n').join('. '));
                setState(() {
                  isSpeechPlaying = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: _getColor(category)),
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromRGBO(21, 34, 56, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getColor(String category) {
    switch (category) {
      case 'Sports':
        return Colors.green;
      case 'Politics':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}

class PlainWidgetScreen extends StatelessWidget {
  final String content;

  const PlainWidgetScreen({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Your News Update'),
      ),
      body: Container(
        color: Color.fromRGBO(21, 34, 56, 1),
        child: TyperAnimatedTextKit(
          isRepeatingAnimation: false,
          speed: Duration(milliseconds: 70),
          text: [content],
          textStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
