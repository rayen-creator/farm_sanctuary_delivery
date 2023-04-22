import 'package:farm_sanctuary_delivery/routes/routes_names.dart';
import 'package:farm_sanctuary_delivery/screens/Login.dart';
import 'package:farm_sanctuary_delivery/screens/Menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes{
    static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const Login());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const Menu());

      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }
}