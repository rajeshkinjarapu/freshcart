import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';
import '../models/user_address.dart';

class AuthService {
  AuthService._(); static final instance = AuthService._();
  final auth = FirebaseAuth.instance; final db = FirebaseFirestore.instance;
  User? get currentUser => auth.currentUser;
  Future<bool> hasSeenOnboarding() async => (await SharedPreferences.getInstance()).getBool('seen_onboarding') ?? false;
  Future<void> markOnboardingSeen() async => (await SharedPreferences.getInstance()).setBool('seen_onboarding', true);
  Future<void> sendOtp(String phone, {required void Function(String) onCodeSent, required void Function(FirebaseAuthException) onError}) async {
    await auth.verifyPhoneNumber(phoneNumber: phone, verificationCompleted: (c) async => auth.signInWithCredential(c), verificationFailed: onError, codeSent: (id, _) => onCodeSent(id), codeAutoRetrievalTimeout: (_) {});
  }
  Future<UserCredential> verifyOtp(String id, String code) => auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: id, smsCode: code));
  Future<bool> userProfileExists(String uid) async => (await db.collection('users').doc(uid).get()).exists;
  Future<void> saveUser(AppUser user) => db.collection('users').doc(user.uid).set(user.toMap(), SetOptions(merge: true));
  Future<void> saveAddress(UserAddress address) => db.collection('users').doc(currentUser!.uid).collection('addresses').add(address.toMap());
}
