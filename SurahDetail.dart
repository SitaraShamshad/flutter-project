import 'package:flutter/material.dart';

class SurahDetailScreen extends StatelessWidget {
  final Map<String, dynamic> surah;

  SurahDetailScreen({required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah['name']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Surah Number: ${surah['number']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Arabic Text:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              surah['arabicText'],
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
