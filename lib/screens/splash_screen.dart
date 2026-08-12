import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final loggedIn = AuthService.instance.currentUser != null;
      final seen = await AuthService.instance.hasSeenOnboarding();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, loggedIn ? '/app' : (seen ? '/login' : '/onboarding'));
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.shopping_basket_rounded, size: 82, color: AppTheme.primary),
          SizedBox(height: 16), Text('FreshCart', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 8), Text('Fresh food, delivered fast'),
        ]),),
      );
}
