import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class GPSMapsScreen extends StatefulWidget {
  @override
  _GPSMapsScreenState createState() => _GPSMapsScreenState();
}

class _GPSMapsScreenState extends State<GPSMapsScreen> {
  late LocationData _currentLocation;
  bool _isLoading = true;

  final Location _locationService = Location();

  // Define a default LatLng in case the location is not available
  LatLng _center = const LatLng(37.7749, -122.4194); // Default is San Francisco

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    // Check for location permissions
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return; // Exit if service is not enabled
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return; // Exit if permission is not granted
      }
    }

    // Get the current location
    _currentLocation = await _locationService.getLocation();
    setState(() {
      _center = LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    //_magnetometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: const Color.fromARGB(255, 0, 218, 233),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: _center,
                initialZoom: 15.0, // Initial zoom level
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'], // OpenStreetMap subdomains
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _center,
                      child: const Icon(
                        Icons.location_on,
                        size: 50.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
