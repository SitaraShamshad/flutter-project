import 'package:flutter/material.dart';

class PrayerTimesScreen extends StatelessWidget {
  final List<Map<String, String>> prayerTimes = [
    {'Fajr': '3:40 AM'},
    {'Sunrise': '5:07 AM'},
    {'Dhuhr': '1:30 PM'},
    {'Asr': '5:00 PM'},
    {'Maghrib': '7:15 PM'},
    {'Isha': '8:50 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFE8673), Color(0xFFFFA69E)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: _buildPrayerTimes(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPrayerTimes(BuildContext context) {
    DateTime now = DateTime.now();
    int currentIndex = -1;

    for (int i = 0; i < prayerTimes.length; i++) {
      DateTime prayerTime = _parseTime(prayerTimes[i].values.first);
      if (now.isBefore(prayerTime)) {
        currentIndex = i;
        break;
      }
    }

    if (currentIndex == -1) {
      currentIndex = prayerTimes.length - 1;
    }

    return prayerTimes.asMap().entries.map((entry) {
      int index = entry.key;
      String prayer = entry.value.keys.first;
      String time = entry.value.values.first;

      return _buildPrayerTimeRow(prayer, time, context, index == currentIndex);
    }).toList();
  }

  DateTime _parseTime(String time) {
    List<String> parts = time.split(' ');
    List<String> timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (parts[1] == 'PM' && hour != 12) {
      hour += 12;
    } else if (parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  Widget _buildPrayerTimeRow(String prayer, String time, BuildContext context, bool isCurrent) {
    Color bgColor = isCurrent ? Color(0xFF00C853) : Colors.transparent;
    Color textColor = isCurrent ? Colors.white : Colors.black;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        border: isCurrent ? null : Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isCurrent ? Icons.volume_up : Icons.volume_off,
                color: isCurrent ? Colors.white : Colors.black,
              ),
              SizedBox(width: 8),
              Text(
                prayer,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ],
      ),
    );
  }
}
