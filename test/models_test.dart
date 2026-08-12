import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_delivery_app/models/product.dart';
import 'package:grocery_delivery_app/models/cart_item.dart';
void main(){test('product uses discount price when valid',(){const p=Product(id:'1',name:'Milk',categoryId:'dairy',price:70,discountPrice:60);expect(p.salePrice,60);});test('cart item serializes correctly',(){const i=CartItem(productId:'1',name:'Milk',price:60,quantity:2);expect(i.toMap()['quantity'],2);});}
