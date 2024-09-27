import 'package:ambient_light/ambient_light.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LightSensorScreen extends StatefulWidget {
  @override
  _LightSensorScreenState createState() => _LightSensorScreenState();
}

class _LightSensorScreenState extends State<LightSensorScreen> {
  final AmbientLight _ambientLight = AmbientLight();
  double? _currentAmbientLight;
  StreamSubscription<double>? _ambientLightSubscription;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _ambientLightSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startListening() async {
    _ambientLightSubscription?.cancel();
    _ambientLightSubscription = _ambientLight.ambientLightStream.listen((lux) {
      if (!mounted) return;

      setState(() {
        _currentAmbientLight = lux;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double lightValue = _currentAmbientLight ?? 0;
    double brightnessFactor = (lightValue / 1000).clamp(0.0, 1.0);
    Color backgroundColor =
        Color.lerp(Colors.black, Colors.orange, brightnessFactor)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Light Sensor'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedContainer(
        duration:  const Duration(milliseconds: 500),
        color: backgroundColor, // Set the background color dynamically
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _currentAmbientLight != null
                      ? '${_currentAmbientLight!.round()} lux'
                      : 'Fetching ambient light...',
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
