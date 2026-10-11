
import 'package:flutter/material.dart';
import 'role_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const RolePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const coral = Color(0xFFF7636B);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF4EB),
              Color(0xFFFFE4DA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_crumbly.png',
              height: 130,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.cake,
                size: 100,
                color: coral,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: coral,
            ),
          ],
        ),
      ),
    );
  }
}