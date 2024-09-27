import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BarometerScreen extends StatefulWidget {
  @override
  _BarometerScreenState createState() => _BarometerScreenState();
}

class _BarometerScreenState extends State<BarometerScreen> {
  static const Duration _ignoreDuration = Duration(milliseconds: 20);

  BarometerEvent? _barometerEvent;
  int? _barometerLastInterval;
  DateTime? _barometerUpdateTime;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Duration sensorInterval = SensorInterval.normalInterval;

  double _minPressure = 950; // Low pressure for gradient
  double _maxPressure = 1050; // High pressure for gradient

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      barometerEventStream(samplingPeriod: sensorInterval).listen(
        (BarometerEvent event) {
          final now = event.timestamp;
          setState(() {
            _barometerEvent = event;
            if (_barometerUpdateTime != null) {
              final interval = now.difference(_barometerUpdateTime!);
              if (interval > _ignoreDuration) {
                _barometerLastInterval = interval.inMilliseconds;
              }
            }
          });
          _barometerUpdateTime = now;
        },
        onError: (e) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Barometer Sensor"),
                );
              },
            );
          }
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  void dispose() {
    // Cancel all active subscriptions when the widget is disposed
    for (var subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barometer'),
        backgroundColor: const Color.fromARGB(255, 55, 175, 0),
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${_barometerEvent?.pressure.toStringAsFixed(1) ?? '?'} hPa',
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
