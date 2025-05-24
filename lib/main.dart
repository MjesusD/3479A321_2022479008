import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_3479a321lab3/pages/home_page.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';
import 'package:aplicacion_3479a321lab3/services/database_helper.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Para servicios async antes de runApp
  await DatabaseHelper().initializeDatabase(); // Inicializa la base de datos antes de runApp
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    logger.i('Logger is working!');
    const appName = 'MyApp';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: const MyHomePage(title: appName),
    );
  }
}
