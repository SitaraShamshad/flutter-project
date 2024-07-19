import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:geocoding/geocoding.dart';
import 'GreetingScreen.dart';
import 'InspirationScreen.dart';
import 'PrayerTimesCREEN.dart';
import 'ProfileScreen.dart';
import 'SuraList.dart';
import 'TasbihScreen.dart';
import 'Tracker.dart';
import 'goaltracker.dart';
import 'DuaScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentPrayer = 'Loading...';
  String hijriDate = 'Loading...';
  String location = 'Loading...';
  PrayerTimes? prayerTimes;
  String dailyQuote = 'Loading...';
  String dailyAyat = 'Loading...'; // Initialize dailyAyat
  bool isFirstTime = true;

  final List<String> quotes = [
    "The best among you is the one who doesn’t harm others with his tongue and hands. - Prophet Muhammad (PBUH)",
    "Do not grieve, indeed Allah is with us. - Quran 9:40",
    "And He found you lost and guided [you]. - Quran 93:7",
    "The seeking of knowledge is obligatory for every Muslim. - Prophet Muhammad (PBUH)",
    "Indeed, prayer prohibits immorality and wrongdoing. - Quran 29:45"
  ];
  final List<String> ayatList = [
    "Surah Al-Fatiha, Ayah 1: Bismillah ir-Rahman ir-Rahim",
    "Surah Al-Baqarah, Ayah 255: Ayat-ul-Kursi",
    "Surah Al-Ikhlas, Ayah 1-4: Qul huwa Allahu ahad...",
    "Surah Al-Mulk, Ayah 15: Huwal-ladhi khalaqas-samawati wal-arda...",
    "Surah Al-Ankabut, Ayah 69: Wala-ladhina jahadu fiina lanahdiyannahum subulana...",
  ];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _setDailyQuote();
    _setDailyAyat();
  }

  void _setDailyQuote() {
    final now = DateTime.now();
    setState(() {
      dailyQuote = quotes[now.day % quotes.length];
    });
  }

  void _setDailyAyat() {
    final random = Random();
    setState(() {
      dailyAyat = ayatList[random.nextInt(ayatList.length)];
    });
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await _requestLocationPermission();
    } else {
      _fetchLocationAndPrayerTimes();
    }
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle if user denies permission
      print('Location permission denied');
      setState(() {
        location = 'Location permission denied';
      });
    } else if (permission == LocationPermission.deniedForever) {
      // Handle if user denies permission forever
      print('Location permission denied forever');
      setState(() {
        location = 'Location permission denied forever';
      });
    } else {
      // Permission granted, fetch location and prayer times
      _fetchLocationAndPrayerTimes();
    }
  }

  Future<void> _fetchLocationAndPrayerTimes() async {
    Position position;
    try {
      position = await _determinePosition();
      await _getAddressFromLatLng(position);
    } catch (e) {
      print("Error getting position: $e");
      setState(() {
        location = 'Location not found';
      });
      return;
    }
    DateTime now = DateTime.now();
    setState(() {
      hijriDate = HijriCalendar.now().toFormat("dd MMMM yyyy");
    });

    Coordinates coordinates =
    Coordinates(position.latitude, position.longitude);
    CalculationParameters params = CalculationMethod.karachi();
    PrayerTimes pt = PrayerTimes(
        coordinates: coordinates, date: now, calculationParameters: params);

    String current = _getCurrentPrayer(pt, now);
    setState(() {
      currentPrayer = current;
      prayerTimes = pt;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          location = '${place.locality}, ${place.country}';
        });
      } else {
        setState(() {
          location = 'Location not found';
        });
      }
    } catch (e) {
      print("Error getting address: $e");
      setState(() {
        location = 'Location not found';
      });
    }
  }

  String _getCurrentPrayer(PrayerTimes prayerTimes, DateTime now) {
    if (now.isBefore(prayerTimes.fajr!)) return 'Fajr';
    if (now.isBefore(prayerTimes.dhuhr!)) return 'Dhuhr';
    if (now.isBefore(prayerTimes.asr!)) return 'Asr';
    if (now.isBefore(prayerTimes.maghrib!)) return 'Maghrib';
    if (now.isBefore(prayerTimes.isha!)) return 'Isha';
    return 'Isha';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF122F2B), // Dark teal color for background
        ),
        child: Column(
          children: [
            _buildTopSection(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSearchBar(),
                      SizedBox(height: 10),
                      _buildOptions(),
                      SizedBox(height: 10),
                      _buildDailyQuote(),
                      SizedBox(height: 10),
                      _buildDailyAyat(),
                      SizedBox(height: 10),
                      _buildCircularOptions(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFF6F4D), // Orange color
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: EdgeInsets.all(32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salaam\n$currentPrayer',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$hijriDate\n$location',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF293A9A), // Blue color
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildOptionItem(Color(0xFF37C295), 'Inspiration', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InspirationScreen()));
              }),
              SizedBox(width: 10),
              _buildOptionItem(Color(0xFF4BC0E4), 'Tracker', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrackerScreen()));
              }),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildOptionItem(Color(0xFFFF8D40), 'Essential Suras', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurahListScreen()));
              }),
              SizedBox(width: 10),
              _buildOptionItem(Color(0xFF7C60E4), 'Greetings', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GreetingsScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(Color color, String text, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(36),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyQuote() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/islamic.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Daily Quote',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            dailyQuote,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyAyat() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/img_4.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical:5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Daily Ayat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            dailyAyat,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCircularOption('Tasbih', Icons.favorite),
          _buildCircularOption('Prayer Times', Icons.access_time),
          _buildCircularOption('Goal Setting', Icons.flag),
          _buildCircularOption('Duas', Icons.book),
          _buildCircularOption('Profile', Icons.person),
        ],
      ),
    );
  }

  Widget _buildCircularOption(String text, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (text == 'Tasbih') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TasbihCounterScreen()),
          );
        } else if (text == 'Prayer Times') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTimesScreen()));
        } else if (text == 'Goal Setting') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GoalTrackerScreen()),
          );
        } else if (text == 'Duas') {
          // Added navigation for Duas
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DuaCategoriesScreen()),
          );
        } else if (text == 'Profile') {
          // Navigate to ProfileScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                username: 'badish',
                email: 'Badashali@gmail.com',
                phone: '+1234567890',
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Color(0xFF008080),
              size: 25,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
