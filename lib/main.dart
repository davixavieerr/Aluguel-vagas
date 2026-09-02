// Caminho: lib/main.dart

import 'package:flutter/material.dart';
import 'features/map/presentation/main_shell_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estaconei',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121418),
      ),
      home: const MainShellScreen(),
    );
  }
}
