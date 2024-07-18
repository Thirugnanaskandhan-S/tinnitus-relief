
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
   apiKey: "AIzaSyAx-fgaHPWsSLZmYQAVOGjtAuVGaZWu-bU",
  authDomain: "faceattendancerealtime-8dce7.firebaseapp.com",
  databaseURL: "https://faceattendancerealtime-8dce7-default-rtdb.firebaseio.com",
  projectId: "faceattendancerealtime-8dce7",
  storageBucket: "faceattendancerealtime-8dce7.appspot.com",
  messagingSenderId: "841074590374",
  appId: "1:841074590374:web:b3744cc95974830d7b2a67",
  measurementId: "G-1ETQ8SXXCD"
  );

  static const FirebaseOptions android = FirebaseOptions(
     apiKey: "AIzaSyAx-fgaHPWsSLZmYQAVOGjtAuVGaZWu-bU",
   appId: "1:841074590374:web:4ecb2e6e3c1248187b2a67",
    messagingSenderId: '841074590374',
    projectId: 'faceattendancerealtime-8dce7',
    storageBucket: 'faceattendancerealtime-8dce7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3IbWxas25D6x0faVcijO_U5ul3CKes-0',
    appId: '1:426881368795:ios:4ed9689b226d1fdb7cc2fe',
    messagingSenderId: '426881368795',
    projectId: 'faceattendance-53dfa',
    storageBucket: 'faceattendance-53dfa.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3IbWxas25D6x0faVcijO_U5ul3CKes-0',
    appId: '1:426881368795:ios:35e59b7f5aa604617cc2fe',
    messagingSenderId: '426881368795',
    projectId: 'faceattendance-53dfa',
    storageBucket: 'faceattendance-53dfa.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
