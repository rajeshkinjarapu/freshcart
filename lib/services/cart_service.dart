import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_item.dart';
class CartService { final db=FirebaseFirestore.instance; String get uid=>FirebaseAuth.instance.currentUser!.uid; Stream<List<CartItem>> watch()=>db.doc('cart/$uid').snapshots().map((d)=>List<Map<String,dynamic>>.from(d.data()?['items']??const []).map(CartItem.fromMap).toList()); Future<void> save(List<CartItem> x)=>db.doc('cart/$uid').set({'userId':uid,'items':x.map((i)=>i.toMap()).toList(),'updatedAt':FieldValue.serverTimestamp()}); }
