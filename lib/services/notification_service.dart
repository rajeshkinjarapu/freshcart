import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class NotificationService { static Future<void> initialize()async{final m=FirebaseMessaging.instance;await m.requestPermission();final token=await m.getToken();final u=FirebaseAuth.instance.currentUser;if(u!=null&&token!=null)await FirebaseFirestore.instance.doc('users/${u.uid}').set({'fcmToken':token},SetOptions(merge:true));FirebaseMessaging.onMessage.listen((message){});}}
