import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';
class OrderService { final db=FirebaseFirestore.instance; String get uid=>FirebaseAuth.instance.currentUser!.uid; Stream<List<OrderModel>> orders()=>db.collection('orders').where('userId',isEqualTo:uid).orderBy('createdAt',descending:true).snapshots().map((s)=>s.docs.map((d)=>OrderModel.fromMap(d.id,d.data())).toList()); Future<void> reorder(OrderModel o)=>db.doc('cart/$uid').set({'userId':uid,'items':o.items.map((x)=>x.toMap()).toList(),'updatedAt':FieldValue.serverTimestamp()}); }
