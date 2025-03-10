// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAyufUHxIIWVqjqcIN_BT6xVBX9w58oqFA',
    appId: '1:222062142269:web:def169bff8d27e500b9b54',
    messagingSenderId: '222062142269',
    projectId: 'dailydeen-f583e',
    authDomain: 'dailydeen-f583e.firebaseapp.com',
    storageBucket: 'dailydeen-f583e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSTIHJdppuvPxFg1DD2MT34KKy49BCORM',
    appId: '1:222062142269:android:e8b1316f9274692d0b9b54',
    messagingSenderId: '222062142269',
    projectId: 'dailydeen-f583e',
    storageBucket: 'dailydeen-f583e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYuyeiWUljJshCS3opKGEDPBmHHbhyfLg',
    appId: '1:222062142269:ios:b1311ee0ea32ebac0b9b54',
    messagingSenderId: '222062142269',
    projectId: 'dailydeen-f583e',
    storageBucket: 'dailydeen-f583e.appspot.com',
    iosBundleId: 'com.example.dailydeen',
  );
}
