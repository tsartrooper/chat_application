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
    apiKey: 'AIzaSyAV6SqmzVf6K1wXBjDHNPHwHCWjwHNUbqI',
    appId: '1:1055592229002:web:e96158fcf93cc54c12a573',
    messagingSenderId: '1055592229002',
    projectId: 'flutter-chat-app-e6b04',
    authDomain: 'flutter-chat-app-e6b04.firebaseapp.com',
    storageBucket: 'flutter-chat-app-e6b04.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmwh32n0tYgospGsFLeOvB7PMSV7GlSZ4',
    appId: '1:1055592229002:android:ad57f17cbe9b9b0512a573',
    messagingSenderId: '1055592229002',
    projectId: 'flutter-chat-app-e6b04',
    storageBucket: 'flutter-chat-app-e6b04.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBr5UgoWg8i7a3WjGEI5r1zyQU_7x6w7jw',
    appId: '1:1055592229002:ios:c377b1c14e6df0a412a573',
    messagingSenderId: '1055592229002',
    projectId: 'flutter-chat-app-e6b04',
    storageBucket: 'flutter-chat-app-e6b04.appspot.com',
    iosBundleId: 'com.example.flutterChatApp',
  );
}
