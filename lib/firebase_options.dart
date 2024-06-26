// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAZuWJ3vomBG1C-AUqeEAneLBbdq4OwNVg',
    appId: '1:815653673603:web:d9d1b226250caae47159b6',
    messagingSenderId: '815653673603',
    projectId: 'groceasy-89b73',
    authDomain: 'groceasy-89b73.firebaseapp.com',
    storageBucket: 'groceasy-89b73.appspot.com',
    measurementId: 'G-FMKSGRRXBF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuQpJjgimkR8IkrY8rJB3-YfgjwYqfyTQ',
    appId: '1:815653673603:android:881da338c1b3122e7159b6',
    messagingSenderId: '815653673603',
    projectId: 'groceasy-89b73',
    storageBucket: 'groceasy-89b73.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAD7KEuqB6jpYzKGzZGk-h6bpvbMsGvML8',
    appId: '1:815653673603:ios:5c3457838f78f16f7159b6',
    messagingSenderId: '815653673603',
    projectId: 'groceasy-89b73',
    storageBucket: 'groceasy-89b73.appspot.com',
    iosBundleId: 'com.example.groceasy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAD7KEuqB6jpYzKGzZGk-h6bpvbMsGvML8',
    appId: '1:815653673603:ios:5c3457838f78f16f7159b6',
    messagingSenderId: '815653673603',
    projectId: 'groceasy-89b73',
    storageBucket: 'groceasy-89b73.appspot.com',
    iosBundleId: 'com.example.groceasy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZuWJ3vomBG1C-AUqeEAneLBbdq4OwNVg',
    appId: '1:815653673603:web:f165a984498e3afd7159b6',
    messagingSenderId: '815653673603',
    projectId: 'groceasy-89b73',
    authDomain: 'groceasy-89b73.firebaseapp.com',
    storageBucket: 'groceasy-89b73.appspot.com',
    measurementId: 'G-6042253SEB',
  );

}