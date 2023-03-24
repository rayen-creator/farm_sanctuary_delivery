import 'package:farm_sanctuary_delivery/screens/Login.dart';
import 'package:farm_sanctuary_delivery/screens/Menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Farm Sanctuary Delivery',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // home: const Login());
        home: const Menu());
  }
}
