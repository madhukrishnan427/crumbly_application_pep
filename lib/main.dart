import 'package:flutter/material.dart';
import 'splash_page.dart';

void main() {
  runApp(const CrumblyApp());
}

class CrumblyApp extends StatelessWidget {
  const CrumblyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crumbly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFFF8F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF7636B),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8F3),
          foregroundColor: Color(0xFF3D3030),
          elevation: 0,
        ),
      ),
      home: const SplashPage(),
    );
  }
}