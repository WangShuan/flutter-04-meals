import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        primaryColor: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: GoogleFonts.mochiyPopPOneTextTheme(Theme.of(context).textTheme).copyWith(
          bodyMedium: GoogleFonts.mochiyPopPOne(color: Colors.indigo[50], fontSize: 16),
          headlineMedium: GoogleFonts.mochiyPopPOne(color: Colors.white70),
          headlineSmall: GoogleFonts.mochiyPopPOne(color: Colors.white, fontSize: 20),
          titleLarge: GoogleFonts.mochiyPopPOne(color: Colors.indigo[100]),
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
