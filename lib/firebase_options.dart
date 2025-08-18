// This file is created as a placeholder since Firebase is removed
// If you want to add Firebase later, run: flutter pub add firebase_core
// Then run: flutterfire configure

class DefaultFirebaseOptions {
  static const android = FirebaseOptions(
    apiKey: 'demo-key',
    appId: 'demo-app-id',
    messagingSenderId: 'demo-sender-id',
    projectId: 'demo-project',
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