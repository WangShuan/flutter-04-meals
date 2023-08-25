import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  await Supabase.initialize(
    url: 'https://bvhbftzgkqdrvhnqvgml.supabase.co',
    anonKey: FlutterConfig.get('SUPABASE_KEY'),
  );

  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

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
