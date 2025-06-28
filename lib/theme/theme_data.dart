import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 0, 0, 0),
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.bebasNeueTextTheme(
      const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    ),
  );
}
