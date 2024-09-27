import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with WidgetsBindingObserver {
  Barcode? _barcode;
  bool _isDialogShown = false; // Flag to prevent multiple dialogs

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh the scanner if needed
      setState(() {});
    }
  }

  void _showAlertDialog(BuildContext context, String url) {
    if (_isDialogShown) return; // Prevent showing multiple dialogs
    _isDialogShown = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open link'),
          content: Text(url),
          actions: [
            TextButton(
              onPressed: () {
                _isDialogShown = false; // Reset the flag
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                _isDialogShown = false; // Reset the flag
                Navigator.of(context).pop();
                _launchURL(url);
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    ).then((_) {
      _isDialogShown = false; // Ensure the flag is reset when the dialog closes
    });
  }

  Future<void> _launchURL(String url) async {
    Uri urlConverted = Uri.parse(url);
    if (!await launchUrl(urlConverted)) {
      throw 'Could not launch $url';
    }
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted && !_isDialogShown) { // Check if dialog is already shown
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        if (_barcode?.displayValue != null) {
          _showAlertDialog(context, _barcode!.displayValue!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        backgroundColor: const Color.fromARGB(255, 255, 44, 44),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
        ],
      ),
    );
  }
}