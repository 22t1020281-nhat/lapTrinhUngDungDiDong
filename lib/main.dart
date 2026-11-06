import 'package:flutter/material.dart';
import 'settings_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Container(
          color: Colors.grey.shade300,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                width: 375,
                height: 812,
                child: child,
              ),
            ),
          ),
        );
      },
      home: const SettingsScreen(),
    );
  }
}