
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

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
    apiKey: 'AIzaSyC_3hkQsZ_j7NTjn81eZNQT9rUMqfwoGf0',
    appId: '1:696104482910:web:2cf96311ef5c50ff925ccf',
    messagingSenderId: '696104482910',
    projectId: 'moviecli',
    authDomain: 'moviecli.firebaseapp.com',
    storageBucket: 'moviecli.firebasestorage.app',
    measurementId: 'G-PV700EE1XQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBy34npA0OS7X2EyFSNYv1cwqf4gvfSSO0',
    appId: '1:696104482910:android:74412afa6f2ba22d925ccf',
    messagingSenderId: '696104482910',
    projectId: 'moviecli',
    storageBucket: 'moviecli.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBg71l6_Rznycl_HNN3VaU9ceoWYwOkvbA',
    appId: '1:696104482910:ios:08a91e1b7820969f925ccf',
    messagingSenderId: '696104482910',
    projectId: 'moviecli',
    storageBucket: 'moviecli.firebasestorage.app',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBg71l6_Rznycl_HNN3VaU9ceoWYwOkvbA',
    appId: '1:696104482910:ios:08a91e1b7820969f925ccf',
    messagingSenderId: '696104482910',
    projectId: 'moviecli',
    storageBucket: 'moviecli.firebasestorage.app',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC_3hkQsZ_j7NTjn81eZNQT9rUMqfwoGf0',
    appId: '1:696104482910:web:c577c0116176bd4b925ccf',
    messagingSenderId: '696104482910',
    projectId: 'moviecli',
    authDomain: 'moviecli.firebaseapp.com',
    storageBucket: 'moviecli.firebasestorage.app',
    measurementId: 'G-8V64RRMSXY',
  );
}
