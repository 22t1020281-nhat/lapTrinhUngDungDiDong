import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Xin chào các bạn",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown, // Hoặc Colors.red
              ),
            ),
            Text(
              "Chào mừng các bạn đến với Flutter",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            Icon(Icons.favorite, color: Colors.red, size: 30)
          ],
        ),
      ),
    );
  }
}