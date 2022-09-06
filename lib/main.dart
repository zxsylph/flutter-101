import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Location location = Location();
late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData locationData;

Future<dynamic> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.serviceEnabled();
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  locationData = await location.getLocation();
  return locationData;
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Location'),
      ),
      body: content(),
    );
  }
}

Widget content() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('dont for get to set location'),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            getLocation().then((value) {
              print(value);
            });
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Get Location',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
