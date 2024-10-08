import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double _heading = 0; // Compass heading
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  @override
  void initState() {
    super.initState();
    _listenToMagnetometer();
  }

  void _listenToMagnetometer() {
    _magnetometerSubscription =
        magnetometerEvents.listen((MagnetometerEvent event) {
      final double x = event.x;
      final double y = event.y;

      // Calculate the heading in radians, then convert to degrees
      double heading = atan2(y, x) * (180 / pi);

      // Normalize the heading between 0 and 360 degrees
      if (heading < 0) {
        heading += 360;
      }

      setState(() {
        _heading = heading; // Update the heading (degrees)
      });
    });
  }

  @override
  void dispose() {
    _magnetometerSubscription?.cancel(); // Cancel the subscription when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass'),
        backgroundColor: const Color.fromARGB(255, 156, 0, 204),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rotating compass arrow based on heading
            Transform.rotate(
              angle: (_heading * (pi / 180) * -1), // Convert degrees to radians and rotate
              child: const Icon(
                Icons.navigation, // Compass arrow icon
                size: 150,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 40),
            // Display heading in degrees
            Text(
              '${_heading.toStringAsFixed(2)}°',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            const Text(
              'North: 0°, East: 90°, South: 180°, West: 270°',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
