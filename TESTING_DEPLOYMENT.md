# Phase 9 — Testing and deployment

## Local verification

```text
flutter pub get
flutter analyze
flutter test
flutter run
```

Before testing, replace the Firebase placeholders and configure Phone Auth, Maps, and Firestore.

## Firebase production checklist

- Create a production Firebase project.
- Run `flutterfire configure`.
- Enable Phone Authentication.
- Create Firestore database in production mode.
- Deploy `firestore.rules` and `firestore.indexes.json`.
- Install and deploy Cloud Functions.
- Enable Firebase Storage and add Storage rules.
- Configure FCM for Android and iOS.
- Add Google Maps keys with package/bundle restrictions.
- Add Razorpay test keys for development; use production keys only after verification.
- Create an admin account and assign the `admin: true` custom claim.

## Android release

1. Set a unique `applicationId` in `android/app/build.gradle`.
2. Create an upload keystore and configure signing in `key.properties`.
3. Set the final version in `pubspec.yaml`, for example `1.0.0+1`.
4. Add the release Google services file.
5. Run:

```text
flutter build appbundle --release
```

6. Upload the generated `.aab` to Google Play Console, complete store listing, privacy policy, content rating, screenshots, and testing tracks.

## iOS release

1. Open `ios/Runner.xcworkspace` in Xcode.
2. Set the bundle identifier, team, signing, icons, and launch screen.
3. Add `GoogleService-Info.plist` and Maps configuration.
4. Set the version and build number.
5. Run:

```text
flutter build ipa --release
```

6. Upload through Xcode or Transporter, then complete App Store Connect metadata, privacy details, screenshots, and TestFlight review.

## Recommended next hardening

- Move order placement fully to the callable `placeOrder` Cloud Function instead of direct client writes.
- Add Firebase App Check.
- Add Storage security rules and image upload limits.
- Add integration tests using Firebase Emulator Suite.
- Add Razorpay signature verification in a Cloud Function.
- Add pagination for products and orders.
