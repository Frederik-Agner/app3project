import 'package:app3project/LightSensor.dart';
import 'package:torch_light/torch_light.dart';
import 'package:app3project/Barometer.dart';
import 'package:app3project/Compass.dart';
import 'package:app3project/Maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Gyroscope.dart';
import 'QRScan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Sensor Testing App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

// Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateQR() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScannerScreen(),
    ));
  }

  void _navigateGyro() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GyroTestScreen(),
    ));
  }

  void _navigateLight() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LightSensorScreen(),
    ));
  }

  void _navigateBarometer() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BarometerScreen(),
    ));
  }

  void _navigateCompass() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CompassScreen(),
    ));
  }

  void _navigateMaps() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GPSMapsScreen(),
    ));
  }

  bool _isFlashlightOn = false;
  Future<void> _toggleFlashlight() async {
    try {
      if (_isFlashlightOn) {
        await TorchLight.disableTorch(); // Turn off flashlight
      } else {
        await TorchLight.enableTorch(); // Turn on flashlight
      }

      setState(() {
        _isFlashlightOn = !_isFlashlightOn; // Toggle flashlight state
      });
    } catch (e) {
      print("Flashlight error: $e");
    }
  }

  var redColor = const Color.fromARGB(255, 255, 44, 44);
  var blueColor = const Color.fromARGB(255, 57, 162, 248);
  var orangeColor = const Color.fromARGB(255, 255, 102, 0);
  var greenColor = const Color.fromARGB(255, 55, 175, 0);
  var purpleColor = const Color.fromARGB(255, 156, 0, 204);
  var lightBlueColor = const Color.fromARGB(255, 0, 218, 233);
  var yellowColor = const Color.fromARGB(255, 194, 191, 0);
  var lightRedColor = const Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    // Define a button height variable for easy customization
    double buttonHeight = 80.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the edges
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Start from the top
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Fill available width
          children: <Widget>[
            // First button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: redColor,
                  side: BorderSide(color: redColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _navigateQR,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code),
                    Text('Scan QR Code'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Second button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: blueColor,
                  side: BorderSide(color: blueColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _navigateGyro,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.compass_calibration),
                    Text('Gyroscope'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Third button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: orangeColor,
                  side: BorderSide(color: orangeColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _navigateLight,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.light_mode),
                    Text('Light Sensor'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Fourth button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: greenColor,
                  side: BorderSide(color: greenColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _navigateBarometer,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.speed),
                    Text('Barometer'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Fifth button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: purpleColor,
                  side: BorderSide(color: purpleColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _navigateCompass,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.north_east),
                    Text('Compass'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Sixth button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: lightBlueColor,
                  side: BorderSide(color: lightBlueColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _navigateMaps,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map),
                    Text('Maps'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Seventh button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: _isFlashlightOn
                      ? yellowColor
                      : Colors.transparent, // Fill when flashlight is on
                  foregroundColor: Colors.white,
                  side: BorderSide(color: yellowColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _toggleFlashlight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_isFlashlightOn
                        ? Icons.flashlight_on
                        : Icons.flashlight_off), // Toggle icon based on state
                    Text(_isFlashlightOn
                        ? 'Flashlight ON'
                        : 'Flashlight OFF'), // Update label
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between buttons

            // Eighth button
            SizedBox(
              height: buttonHeight, // Control button height here
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: lightRedColor,
                  side: BorderSide(color: lightRedColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.vibrate();
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard),
                    Text('More Buttons'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
