import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
class AppShell extends StatefulWidget{const AppShell({super.key});@override State<AppShell> createState()=>_AppShellState();}
class _AppShellState extends State<AppShell>{int index=0;final pages=const[HomeScreen(),OrdersScreen(),CartScreen(),ProfileScreen()];@override Widget build(BuildContext c)=>Scaffold(body:pages[index],bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(i)=>setState(()=>index=i),destinations:const[NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Home'),NavigationDestination(icon:Icon(Icons.receipt_long_outlined),selectedIcon:Icon(Icons.receipt_long),label:'Orders'),NavigationDestination(icon:Icon(Icons.shopping_cart_outlined),selectedIcon:Icon(Icons.shopping_cart),label:'Cart'),NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'Profile')]));}
