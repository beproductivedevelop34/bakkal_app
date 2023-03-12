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
    apiKey: 'AIzaSyCcmBr__SVcurFf8i8aybQIPvAVOm5re6A',
    appId: '1:206534657012:web:380e994e1ced4009a02fa1',
    messagingSenderId: '206534657012',
    projectId: 'bakkalapp67',
    authDomain: 'bakkalapp67.firebaseapp.com',
    storageBucket: 'bakkalapp67.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPsdyG_vwYgFrfgIihO-0EfkOBULKpx_8',
    appId: '1:206534657012:android:0952921859b520dea02fa1',
    messagingSenderId: '206534657012',
    projectId: 'bakkalapp67',
    storageBucket: 'bakkalapp67.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBo4gdv-IKRIYlMz1aHsKeR5e6GJbt6vMI',
    appId: '1:206534657012:ios:45deb224a0ab3c9ca02fa1',
    messagingSenderId: '206534657012',
    projectId: 'bakkalapp67',
    storageBucket: 'bakkalapp67.appspot.com',
    iosClientId: '206534657012-kug26m4h39kcppj59bgj8i59el2klrje.apps.googleusercontent.com',
    iosBundleId: 'com.example.bakkalApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBo4gdv-IKRIYlMz1aHsKeR5e6GJbt6vMI',
    appId: '1:206534657012:ios:45deb224a0ab3c9ca02fa1',
    messagingSenderId: '206534657012',
    projectId: 'bakkalapp67',
    storageBucket: 'bakkalapp67.appspot.com',
    iosClientId: '206534657012-kug26m4h39kcppj59bgj8i59el2klrje.apps.googleusercontent.com',
    iosBundleId: 'com.example.bakkalApp',
  );
}