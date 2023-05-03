import 'dart:async';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:farm_sanctuary_delivery/models/Order.dart';
import 'package:farm_sanctuary_delivery/screens/Home.dart';
import 'package:farm_sanctuary_delivery/screens/Settings.dart';
import 'package:farm_sanctuary_delivery/services/graphqlService.dart';
import 'package:farm_sanctuary_delivery/services/sessionService.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final SessionService _session;
  String username = "";
  String id = "";
  final GraphQLService _graphQLService = GraphQLService();
  late Timer _timer;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;
  // This function will get user location
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _userLocation = locationData;
      var longtitude = _userLocation?.longitude.toString();
      var latitude = _userLocation?.latitude.toString();
      if (longtitude != null && latitude != null) {
        _graphQLService.SendLocation(longtitude, latitude);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _session = SessionService();
    _session.init().then((_) {
      setState(() {
        username = _session.login ?? '';
        id = _session.id ?? '';
      });
    });

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _getUserLocation();
    });

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Home(
            id: id,
          ),
          Settings(
            username: username,
          )
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: const [
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.green,
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
