import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[800],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
    iconTheme: IconThemeData(color: Colors.black, size: 40),
  ),
  textTheme: GoogleFonts.exo2TextTheme(
    const TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      bodySmall: TextStyle(
        color: Colors.white54,
        fontSize: 15,
      ),
    ),
  ),
);
