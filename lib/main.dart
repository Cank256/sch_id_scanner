import 'package:flutter/material.dart';
import 'qr_scan.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppState(), // Use the MyAppState widget from qr_scan.dart
    );
  }
}
