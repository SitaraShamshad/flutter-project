import 'package:flutter/material.dart';

class InspirationScreen extends StatelessWidget {
  // List of image paths
  final List<String> imagePaths = [
    'images/img.png',
    'images/img_1.png',
    'images/img_2.png',
    'images/img_3.png',
    'images/img.png',
    'images/img_1.png',
    'images/img_2.png',
    'images/img_3.png',
    'images/img.png',
    'images/img_1.png',
    'images/img_2.png',
    'images/img_3.png',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Inspirational Quotes'),
        backgroundColor: Color(0xFFB3E5FC), // Light blue color
      ),
      body: Container(
        color: Color(0xFF122F2B),
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return _buildInspirationCard(imagePaths[index]);
          },
        ),
      ),
    );
  }

  Widget _buildInspirationCard(String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
