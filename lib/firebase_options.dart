import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

// Firebase configuration placeholder
// For production, replace with actual Firebase configuration
// Run: flutterfire configure --project=your-project-id

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform.',
        );
    }
  }

  static const android = FirebaseOptions(
    apiKey: 'AIzaSyDemo-Replace-With-Actual-Key',
    appId: '1:123456789:android:demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'samad-nursing-home-demo',
    storageBucket: 'samad-nursing-home-demo.appspot.com',
  );

  static const ios = FirebaseOptions(
    apiKey: 'AIzaSyDemo-Replace-With-Actual-iOS-Key',
    appId: '1:123456789:ios:demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'samad-nursing-home-demo',
    storageBucket: 'samad-nursing-home-demo.appspot.com',
    iosBundleId: 'com.samadhospital.samadNursingHome',
  );
}

class FirebaseOptions {
  const FirebaseOptions({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
  });

  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
}