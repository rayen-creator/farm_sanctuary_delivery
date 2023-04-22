import 'package:farm_sanctuary_delivery/routes/routes.dart';
import 'package:farm_sanctuary_delivery/routes/routes_names.dart';
import 'package:farm_sanctuary_delivery/screens/Login.dart';
import 'package:farm_sanctuary_delivery/screens/Menu.dart';
import 'package:farm_sanctuary_delivery/services/sessionService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('loggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Farm Sanctuary Delivery',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: _isLoggedIn ? RoutesName.home : RoutesName.login);

    // home: const Login());
    // home: const Menu());
  }
}
