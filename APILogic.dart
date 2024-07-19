import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class QuranService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> fetchSurahsAndStoreInFirebase() async {
    try {
      final Uri url = Uri.parse('https://api.quran.com:443/api/v4/surahs');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> surahs = json.decode(response.body)['surahs'];

        // Store surahs in Firebase Firestore
        await _storeSurahsInFirestore(surahs);

        return surahs;
      } else {
        throw Exception('Failed to load surahs');
      }
    } catch (e) {
      print('Error fetching and storing surahs: $e');
      throw Exception('Error fetching and storing surahs: $e');
    }
  }

  Future<void> _storeSurahsInFirestore(List<dynamic> surahs) async {
    try {
      CollectionReference surahsCollection = firestore.collection('surahs');

      for (var surah in surahs) {
        await surahsCollection.doc(surah['number'].toString()).set({
          'name': surah['name'],
          'number': surah['number'],
          'arabicText': surah['arabicText'],
        });
      }

      print('Surahs stored in Firestore successfully!');
    } catch (e) {
      print('Error storing surahs in Firestore: $e');
      throw Exception('Error storing surahs in Firestore: $e');
    }
  }
}
