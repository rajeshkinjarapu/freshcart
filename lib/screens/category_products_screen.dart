import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/catalog_provider.dart';
import '../services/catalog_service.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
class CategoryProductsScreen extends StatelessWidget { final String categoryId,title; const CategoryProductsScreen({super.key,required this.categoryId,required this.title}); @override Widget build(BuildContext c)=>ChangeNotifierProvider(create:(_)=>CatalogProvider(),child:Scaffold(appBar:AppBar(title:Text(title),actions:[PopupMenuButton<String>(onSelected:(v)=>c.read<CatalogProvider>().setSort(v),itemBuilder:(_)=>const [PopupMenuItem(value:'popular',child:Text('Popular')),PopupMenuItem(value:'low',child:Text('Price: Low to High')),PopupMenuItem(value:'high',child:Text('Price: High to Low'))])]),body:StreamBuilder<List<Product>>(stream:CatalogService().products(categoryId:categoryId),builder:(c,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());final items=c.watch<CatalogProvider>().filter(s.data!);return GridView.builder(padding:const EdgeInsets.all(12),itemCount:items.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:.70,crossAxisSpacing:10,mainAxisSpacing:10),itemBuilder:(_,i)=>ProductCard(product:items[i],onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ProductDetailScreen(product:items[i])))));}))); }
