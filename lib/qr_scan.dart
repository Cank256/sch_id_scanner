import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:id_scanner/popup_functions.dart';

class MyAppState extends StatefulWidget {
  const MyAppState({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppState> {
  String _scanQR = '';
  late SharedPreferences _prefs;
  final _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _resetDailyCountsIfNecessary();
  }

  Future<void> _resetDailyCountsIfNecessary() async {
    final storedDate = _prefs.getString('lastResetDate') ?? '';
    final currentDate = _dateFormat.format(DateTime.now());
    if (storedDate != currentDate) {
      await _prefs.clear();
      await _prefs.setString('lastResetDate', currentDate);
    }
  }

  Future<void> scanQR() async {
    String qrScanRes;
    try {
      qrScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      debugPrint(qrScanRes);
    } on PlatformException {
      qrScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanQR = qrScanRes;
    });

    String? extractedId = _extractId(_scanQR);
    if (extractedId != null) {
      _processScannedId(extractedId, _scanQR);
    } else {
      showIdScanFormatError(context);
    }
  }

  String? _extractId(String qrData) {
    // Check if qrData contains the 'ID No. ' string
    if (qrData.contains('ID No. ')) {
      // If it does, split the string by 'ID No. ', then split by '\n', trim, and return the first element
      return qrData.split('ID No. ')[1].split('\n')[0].trim();
    }
    // Check if qrData is a URL containing 'https://qrfy.com/profile/'
    else if (qrData.contains('http')) {
      // If it does, split the string by '/', and return the last element
      return qrData.split('/').last;
    }
    // If none of the conditions are met, return null
    return null;
  }

  void _processScannedId(String id, String url) {
    final String key = 'ID-$id';
    final int scanCount = _prefs.getInt(key) ?? 0;

    if (scanCount < 1) {
      _prefs.setInt(key, scanCount + 1);
      showIdScanSuccess(context, url);
    } else {
      showIdScanLimitError(context, id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FlutterSmartDialog.init(),
      home: Scaffold(
        appBar: AppBar(title: const Text('School ID Scanner')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Material(
                  shape: const CircleBorder(),
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(Icons.qr_code),
                    onPressed: scanQR,
                    iconSize: 40,
                    color: Colors.blue,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Scan QR Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              if (_scanQR.isNotEmpty) ...[
                const SizedBox(height: 10),
                const Text(
                  'Scanned Data:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$_scanQR\n',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
