import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/quiz.dart';

class home extends StatefulWidget {
  final String did;
  final String name;

  home({required this.did, required this.name, Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late String currentTinnitusStage = " ";
  late dynamic lastUpdatedFutureTinnitusStage = " ";
  late dynamic recommendedFrequency = " ";
  late dynamic currentFrequency = " ";
  late dynamic firstFrequencyData = " ";
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('Students');
  final String did = " ";

  List<double> pulseData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchPulseData();
  }

  int? tinnitusStage;
  
  final databaseRef = FirebaseDatabase.instance.reference();
  Future<void> fetchData() async {
    try {
      DatabaseEvent snapshot = await databaseRef
          .child('Students/DID324/sri')
          .once() as DatabaseEvent;

      if (snapshot.snapshot.value != null) {
        Map<String, dynamic>? data =
            (snapshot.snapshot.value as Map)?.cast<String, dynamic>();

        if (data != null) {
          currentTinnitusStage = data['Current_tinnnitus_stage']['category'];
          lastUpdatedFutureTinnitusStage = data['Future_tinnitus_stage'].values.last.toString();
          recommendedFrequency = data['Recommended_Frequency_'].values.last.toString();
          firstFrequencyData =
              data.containsKey('frequency') && data['frequency'] is Map
                  ? data['frequency'].values.first.values.first.toString()
                  : "Not available";

          setState(() {});
        } else {
          print('Data is not in the expected format');
        }
      } else {
        print('Data not found');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  void fetchPulseData() async {
    DatabaseEvent event =
        await _database.child(widget.did).child('sri').child('Pulse').once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      Map<dynamic, dynamic>? pulseMap =
          snapshot.value as Map<dynamic, dynamic>?;

      if (pulseMap != null) {
        pulseData = pulseMap.values.map<double>((value) {
          String firstPart = value.values.first.split('|')[0];
          return double.parse(firstPart);
        }).toList();
        print('Pulse Data: $pulseData'); 
        setState(() {});
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  int? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        onQuizCompleted: (stage) {
                          setState(() {
                            tinnitusStage = stage;
                          });
                        },
                      ),
                    ),
                  );

                  
                  if (result != null) {
                    print("Quiz completed with result: $result");
                  }
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(1, 152, 117, 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assessment_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Take your Tinnitus Assessment",
                              style: TextStyle(
                                  fontFamily: 'ubuntu',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  letterSpacing: 1.0),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_circle_right_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   "Stage $tinnitusStage",
              //   style: TextStyle(
              //       fontFamily: 'ubuntu',
              //       fontWeight: FontWeight.w600,
              //       fontSize: 18,
              //       color: Colors.white,
              //       letterSpacing: 1.0),
              // ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(1, 152, 117, 0.5),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Current Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromRGBO(1, 152, 117, 0)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Tinnitus Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    currentTinnitusStage,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromRGBO(1, 152, 117, 0)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Future Tinnitus Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    lastUpdatedFutureTinnitusStage,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromRGBO(1, 152, 117, 0)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Recommended Frequency",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    recommendedFrequency,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromRGBO(1, 152, 117, 0)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Frequency",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    currentTinnitusStage,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromRGBO(1, 152, 117, 0)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Pulse",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    firstFrequencyData.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ]))),
            ],
          ),
        ),
      ),
    );
  }
}