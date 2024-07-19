import 'package:flutter/material.dart';

class GreetingsScreen extends StatelessWidget {
  final List<Greeting> greetings = [
    Greeting(
      english: "As-Salaam-Alaikum",
      meaning: "Peace be upon you",
      arabic: "ٱلسَّلَامُ عَلَيْكُمْ",
      color: Color(0xFF37C295), // Green
    ),
    Greeting(
      english: "Wa-Alaikum-Salaam",
      meaning: "And unto you peace",
      arabic: "وَعَلَيْكُمُ ٱلسَّلَامُ",
      color: Color(0xFF4BC0E4), // Blue
    ),
    Greeting(
      english: "Alhamdulillah",
      meaning: "All praise is due to Allah",
      arabic: "ٱلْـحَـمْـدُ للهِ",
      color: Color(0xFFFF8D40), // Orange
    ),
    Greeting(
      english: "SubhanAllah",
      meaning: "Glory be to Allah",
      arabic: "سُبْحَانَ ٱللَّٰهُ",
      color: Color(0xFF7C60E4), // Purple
    ),
    Greeting(
      english: "InshaAllah",
      meaning: "If Allah wills",
      arabic: "إنْ شَاءَ ٱللَّٰهُ",
      color: Color(0xFFE91E63), // Pink
    ),
    Greeting(
      english: "Bismillah",
      meaning: "In the name of Allah",
      arabic: "بِسْمِ ٱللَّٰهِ",
      color: Color(0xFFFFEB3B), // Yellow
    ),
    Greeting(
      english: "Allahu Akbar",
      meaning: "Allah is the greatest",
      arabic: "ٱللَّٰهُ أَكْبَرُ",
      color: Color(0xFF009688), // Teal
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greetings'),
        backgroundColor: Color(0xFF122F2B),
      ),
      body: Container(
        color: Color(0xFF122F2B), // Background color for the screen
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: greetings.length,
          itemBuilder: (context, index) {
            return _buildGreetingCard(greetings[index]);
          },
        ),
      ),
    );
  }

  Widget _buildGreetingCard(Greeting greeting) {
    return Card(
      color: greeting.color, // Different color for each card
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
              greeting.english,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              greeting.arabic,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Text(
              greeting.meaning,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Greeting {
  final String english;
  final String meaning;
  final String arabic;
  final Color color;

  Greeting({
    required this.english,
    required this.meaning,
    required this.arabic,
    required this.color,
  });
}
