import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';
import '../models/product.dart';
class CatalogService { final _db=FirebaseFirestore.instance; Stream<List<Category>> categories() => _db.collection('categories').orderBy('priority').snapshots().map((s)=>s.docs.map((d)=>Category.fromMap(d.id,d.data())).toList()); Stream<List<Product>> products({String? categoryId}) { Query<Map<String,dynamic>> q=_db.collection('products').where('isAvailable',isEqualTo:true); if(categoryId!=null) q=q.where('categoryId',isEqualTo:categoryId); return q.snapshots().map((s)=>s.docs.map((d)=>Product.fromMap(d.id,d.data())).toList()); } }
