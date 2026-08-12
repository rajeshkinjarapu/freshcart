# FreshCart — Flutter project foundation

## Setup

1. Install Flutter and run `flutter create .` in this directory to generate native Android/iOS runners.
2. Run `flutterfire configure` and replace `lib/firebase_options.dart` with the generated file.
3. Add the downloaded `google-services.json` to `android/app/` and `GoogleService-Info.plist` to `ios/Runner/`.
4. Run `flutter pub get`, then `flutter run`.

The `lib/` folders are organized for screens, widgets, models, services, providers, utilities, and constants.

See [TESTING_DEPLOYMENT.md](TESTING_DEPLOYMENT.md) for testing, Firebase production setup, and store publishing steps.
