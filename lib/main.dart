import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/location_setup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/app_shell.dart';
import 'admin/admin_login_screen.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  runApp(const GroceryDeliveryApp());
}

class GroceryDeliveryApp extends StatelessWidget {
  const GroceryDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshCart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(), '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(), '/profile-setup': (_) => const ProfileSetupScreen(),
        '/location-setup': (_) => const LocationSetupScreen(), '/home': (_) => const HomeScreen(),
        '/admin': (_) => const AdminLoginScreen(), '/app': (_) => const AppShell(),
      },
    );
  }
}
