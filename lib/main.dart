import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/tabs_screen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bvhbftzgkqdrvhnqvgml.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ2aGJmdHpna3FkcnZobnF2Z21sIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEwNjQxNDUsImV4cCI6MjAwNjY0MDE0NX0.Qraq7NFrTtss7uJXwZ4ztP5GzLi21gVKm8a2evjXrB4',
  );
  runApp(const ProviderScope(child: MyApp()));
}

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
