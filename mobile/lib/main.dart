import 'package:flutter/material.dart';
import 'app_shells.dart';

void main() => runApp(const FerryXApp());

class FerryXApp extends StatelessWidget {
  const FerryXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0E5FE3),
      ),
      home: const AppShell(), // ✅ one place only
    );
  }
}
