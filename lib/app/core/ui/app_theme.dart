import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _canvasColor = Color(0xFFF5F5F5);
  static const Color _primaryColor = Color(0xFF011E38);
  static const Color _secondaryColor = Color(0xFF264FEC);
  static const Color _tertiaryColor = Colors.pink;

  static final ThemeData _tema = ThemeData();

  static ThemeData get theme => ThemeData(
    canvasColor: _canvasColor,
    scaffoldBackgroundColor: _canvasColor,
    colorScheme: _tema.colorScheme.copyWith(
      primary: _primaryColor,
      secondary: _secondaryColor,
      tertiary: _tertiaryColor,
      surface: _canvasColor,
      error: Colors.red,
    ),

    textTheme: GoogleFonts.mandaliTextTheme(),

    iconTheme: const IconThemeData(size: 24),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarHeight: 56,
      backgroundColor: _primaryColor,
      surfaceTintColor: _primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minimumSize: Size(double.infinity, 45),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minimumSize: Size(double.infinity, 45),
        side: BorderSide(color: _secondaryColor),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _tertiaryColor,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
    ),
  );
}
