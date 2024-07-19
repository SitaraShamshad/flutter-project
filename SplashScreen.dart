import 'package:flutter/material.dart';
import 'homepage.dart';
import 'welcomescreen.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Simulate a delay for splash screen
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash.jpg'),
            fit: BoxFit.cover, // cover the entire screen
          ),
        ),
        child: Center(
          child: Text(
            'Daily Deen',
            style: TextStyle(fontSize: 40, color: Colors.white,fontWeight:FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
