import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/registration.dart';

class MyHomePage extends StatefulWidget {
  final void Function(int)? onQuizCompleted;

  const MyHomePage({Key? key, this.onQuizCompleted}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentQuestionIndex = 0;
  final List<Map<String, dynamic>> questions = [
   
   {
      'question': 'a. What is Your age group:',
      'options': [
        '1-10',
        '11-30',
        '31-50',
        'Above 50',
      ],
    },
    {
      'question': 'B. Duration of Tinnitus:',
      'options': [
        "I haven't had it for very long (less than 6 months)",
        "I've had it for a while (6 months to 2 years) - it has been worse recently",
        "I've had it for a while (more than 2 years) - it only bothers me sometimes",
      ],
    },
    {
      'question': 'C. Focus on Tinnitus Sound:',
      'options': [
        'Rarely (almost never)',
        'Sometimes (occasionally distracts me)',
        'Often (frequently distracts me)',
        'Most of the time (constant distraction)',
      ],
    },
    {
      'question': 'D. Emotional Impact of Tinnitus:',
      'options': [
        'Rarely (almost no impact)',
        'Sometimes (mildly unpleasant)',
        'Often (significantly bothersome)',
        'Most of the time (distressing and overwhelming)',
      ],
    },
    {
      'question': 'E. Worry about Tinnitus:',
      'options': [
        'Rarely (almost never worry about it)',
        'Sometimes (occasional concern)',
        'Often (frequent worry and anxiety)',
        'Most of the time (constant worry and stress)',
      ],
    },
    {
      'question': 'F. Feeling of Isolation:',
      'options': [
        'Rarely (feels no isolation)',
        'Sometimes (occasional feelings of isolation)',
        'Often (frequent feelings of isolation)',
        'Most of the time (feels constantly isolated)',
      ],
    },
    {
      'question': 'G. Sleep Difficulty:',
      'options': [
        'Rarely (sleeps soundly)',
        'Sometimes (occasional sleep disturbances)',
        'Often (frequent sleep disruptions)',
        'Most of the time (severely disrupted sleep)',
      ],
    },
    {
      'question': 'H. Use of Sleep Sounds:',
      'options': [
        'Rarely (rarely uses sleep sounds)',
        'Sometimes (sometimes uses sleep sounds)',
        'Often (frequently uses sleep sounds)',
        'Most of the time (relies on sleep sounds)',
      ],
    },
    {
      'question': 'I. Medication for Sleep:',
      'options': [
        'Rarely (never uses medication for sleep)',
        'Sometimes (occasionally uses medication for sleep)',
        'Often (frequently uses medication for sleep)',
        'Most of the time (relies on medication for sleep)',
      ],
    },
    {
      'question': 'J. Concentration Difficulty:',
      'options': [
        'Rarely (almost no impact on concentration)',
        'Sometimes (mildly affects concentration)',
        'Often (significantly affects concentration)',
        'Most of the time (makes concentration very difficult)',
      ],
    },
    {
      'question': 'K. Worsening with Fatigue:',
      'options': [
        'Rarely (no effect of fatigue on tinnitus)',
        'Sometimes (slightly worse with fatigue)',
        'Often (significantly worse with fatigue)',
        'Most of the time (becomes unbearable with fatigue)',
      ],
    },
    {
      'question': 'L. Regret or Blame:',
      'options': [
        'Rarely (feels no regret or blame)',
        'Sometimes (occasional feelings of regret or blame)',
        'Often (frequent feelings of regret or blame)',
        'Most of the time (consumed by regret or blame)',
      ],
    },
    {
      'question': 'M. Sensitivity to Noise:',
      'options': [
        'Rarely (bothered by noise only in extreme cases)',
        'Sometimes (occasionally bothered by normal noises)',
        'Often (frequently bothered by everyday noises)',
        'Most of the time (overwhelmed by most noises)',
      ],
    },
    {
      'question': 'N. Spikes or Variations in Intensity:',
      'options': [
        'Rarely (almost never experiences spikes)',
        'Sometimes (occasional spikes in intensity)',
        'Often (frequent spikes in intensity)',
        'Most of the time (constant fluctuations in intensity)',
      ],
    },
    {
      'question': 'O. Feeling in Control:',
      'options': [
        'Rarely (feels no control over tinnitus)',
        'Sometimes (occasional sense of control)',
        'Often (frequent sense of control)',
        'Most of the time (feels entirely in control)',
      ],
    },
  ];

  String _selectedOption = "";
  Map<String, int> optionPoints = {
    "Rarely": 1,
    "Sometimes": 2,
    "Often": 3,
    "Most of the time": 4,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, 
        ),
        title: Text("Tinnitus Assessment",
            style: TextStyle(
                fontFamily: 'ubuntu',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.white,
                letterSpacing: 1.0)),
        backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(1, 152, 117, 0.5),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(
                questions[currentQuestionIndex]['question'],
                style: TextStyle(
                    fontFamily: 'ubuntu',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.0),
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              children: List.generate(
                questions[currentQuestionIndex]['options'].length,
                (index) => buildOptionWidget(context, index),
              ),
            ),
            SizedBox(height: 20.0),
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentQuestionIndex > 0
                      ? () {
                          setState(() {
                            currentQuestionIndex--;
                          });
                        }
                      : null,
                  child: Text(
                    "Previous",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ubuntu',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    } else {
                      int tinnitusStage = determineTinnitusStage();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TinnitusHabituationStageScreen(
                            tinnitusStage: tinnitusStage,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? "Submit"
                        : "Next",
                        
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'ubuntu',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int determineTinnitusStage() {
    int stage1Score = 0;
    int stage2Score = 0;
    int stage3Score = 0;

    for (var question in questions) {
      String selectedOption = _selectedOption;
      int? points = optionPoints[selectedOption];


      if (question['question'] == 'C. Focus on Tinnitus Sound:' ||
          question['question'] == 'D. Emotional Impact of Tinnitus:' ||
          question['question'] == 'E. Worry about Tinnitus:' ||
          question['question'] == 'F. Feeling of Isolation:' ||
          question['question'] == 'G. Sleep Difficulty:' ||
          question['question'] == 'H. Use of Sleep Sounds:' ||
          question['question'] == 'I. Medication for Sleep:' ||
          question['question'] == 'J. Concentration Difficulty:' ||
          question['question'] == 'K. Worsening with Fatigue:' ||
          question['question'] == 'L. Regret or Blame:' ||
          question['question'] == 'M. Sensitivity to Noise:' ||
          question['question'] == 'N. Spikes or Variations in Intensity:' ||  
          question['question'] == 'O. Feeling in Control:') {
        stage1Score +=
            points ?? 0; 
      }
// Stage 2 questions
      else if (question['question'] == 'B. Duration of Tinnitus:') {
        stage2Score +=
            points ?? 0;
      }
// Stage 3 questions
      else {
        stage3Score +=
            points ?? 0; 
      }
    }

    if (stage1Score >= stage2Score && stage1Score >= stage3Score) {
      return 1;
    } else if (stage2Score >= stage1Score && stage2Score >= stage3Score) {
      return 2;
    } else {
      return 3;
    }
  }

  Widget buildOptionWidget(BuildContext context, int index) {
    final double optionWidth = MediaQuery.of(context).size.width * 0.8;
    final isSelected =
        _selectedOption == questions[currentQuestionIndex]['options'][index];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = questions[currentQuestionIndex]['options'][index];
          print("Selected option: $_selectedOption");
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            width: optionWidth,
            child: Text(
              questions[currentQuestionIndex]['options'][index],
              style: TextStyle(
                fontSize: 16.0,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class TinnitusHabituationStageScreen extends StatelessWidget {
  final int tinnitusStage;

  const TinnitusHabituationStageScreen({Key? key, required this.tinnitusStage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stageDescription;
    switch (tinnitusStage) {
      case 1:
        stageDescription =
            "You were aware of tinnitus all the time. You could only focus for a few minutes. You often worried or felt down. If your sleep was affected, it was severe.";
        break;
      case 2:
        stageDescription =
            "You are aware of tinnitus often, but not all the time. You can concentrate for longer periods. You sometimes worry or feel down. Your sleep may still be affected.";
        break;
      case 3:
        stageDescription =
            "You are aware of tinnitus occasionally. You can concentrate for most activities. You rarely worry or feel down. Your sleep is not affected.";
        break;
      default:
        throw Exception("Invalid tinnitus stage: $tinnitusStage");
    }

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Tinnitus Habituation Stage",
            style: TextStyle(
                fontFamily: 'ubuntu',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 1.5)),
        backgroundColor:
            Color(0xFF121212), 
        foregroundColor:
            Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: Text(
              "Stage $tinnitusStage",
              style: TextStyle(
                  fontFamily: 'ubuntu',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 1.0),
            ),
          ),
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(48),
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              stageDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors
                      .white),
            ),
          ),
          InkWell(
            onTap: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home(did: didController.text.trim(),name: nameController.text.trim(),)),
            );
              },
            child: Icon(Icons.home))

        ],
      ),
    );
  }
}