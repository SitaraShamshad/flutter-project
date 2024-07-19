import 'package:flutter/material.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  List<List<bool>> prayerTracker = List.generate(7, (_) => List.generate(5, (_) => false));

  int totalPrayers = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Tracker'),
        backgroundColor: Color(0xFF122F2B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: daysOfWeek.length,
                itemBuilder: (context, dayIndex) {
                  return Card(
                    color: Colors.teal[dayIndex * 100 + 300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            daysOfWeek[dayIndex],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(prayers.length, (prayerIndex) {
                              return Column(
                                children: [
                                  Text(
                                    prayers[prayerIndex],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    value: prayerTracker[dayIndex][prayerIndex],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        prayerTracker[dayIndex][prayerIndex] = value!;
                                        _calculateTotalPrayers();
                                      });
                                    },
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                'Total Prayers This Week: $totalPrayers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateTotalPrayers() {
    totalPrayers = prayerTracker.fold(
      0,
          (sum, day) => sum + day.where((prayer) => prayer).length,
    );
  }
}
