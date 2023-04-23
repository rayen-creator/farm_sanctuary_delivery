import 'package:farm_sanctuary_delivery/services/graphqlService.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GraphQLService _graphQLService = GraphQLService();

  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
  final List<int> colorCodes = <int>[600, 500, 100];


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
    _getUserLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(
      AssetImage('assets/images/background.jpg'),
      context,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.9),
        elevation: 0,
        title: const Center(
            child: Text(
          "Delivery list",
          style: TextStyle(
            color: Colors.white,
            // decoration: TextDecoration.underline,
          ),
        )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(onPressed: _getUserLocation, child: const Text('Check Location')),
              const SizedBox(height: 25),
              // Display latitude & longtitude
              _userLocation != null
                  ? Wrap(
                      children: [
                        Text('Your latitude: ${_userLocation?.latitude}'),
                        const SizedBox(width: 10),
                        Text('Your longtitude: ${_userLocation?.longitude}')
                      ],
                    )
                  : const Text('Please enable location service and grant permission')
            ],
          ),
        ),
      ),
    );
  }
}
