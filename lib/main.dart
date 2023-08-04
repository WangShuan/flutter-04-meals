import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/tabs_screen.dart';

void main() => runApp(const MyApp());

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.red,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.mochiyPopPOneTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
