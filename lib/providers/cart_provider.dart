import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';
class CartProvider extends ChangeNotifier { final service=CartService(); List<CartItem> items=[]; double discount=0; void replace(List<CartItem> x){items=x;} void change(CartItem i,int q){items=items.where((x)=>x.productId!=i.productId).toList();if(q>0)items.add(CartItem(productId:i.productId,name:i.name,image:i.image,price:i.price,quantity:q,unit:i.unit));service.save(items);notifyListeners();} double get subtotal=>items.fold(0,(a,b)=>a+b.price*b.quantity); double get delivery=>subtotal>=499||subtotal==0?0:40; double get total=>subtotal+delivery-discount; void apply(double x){discount=x;notifyListeners();} }
