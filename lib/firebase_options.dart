import 'package:firebase_core/firebase_core.dart';

/// Placeholder configuration. Replace values using `flutterfire configure`.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => const FirebaseOptions(
        apiKey: 'REPLACE_WITH_FIREBASE_API_KEY',
        appId: 'REPLACE_WITH_FIREBASE_APP_ID',
        messagingSenderId: 'REPLACE_WITH_SENDER_ID',
        projectId: 'REPLACE_WITH_PROJECT_ID',
        storageBucket: 'REPLACE_WITH_STORAGE_BUCKET',
      );
}
