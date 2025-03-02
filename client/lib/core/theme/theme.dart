import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: AppBarTheme(color: Pallete.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(Pallete.borderColor), // Call the method correctly
      focusedBorder: _border(Pallete.gradient2),
      errorStyle: TextStyle(color: Pallete.errorColor, fontSize: 14),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Pallete.errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Pallete.errorColor, width: 2),
      ),
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColordark,
    appBarTheme: AppBarTheme(color: Pallete.backgroundColordark),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder:
          _border(Pallete.borderColordark), // Call the method correctly
      focusedBorder: _border(Pallete.gradient2),
      errorStyle: TextStyle(color: Pallete.errorColor, fontSize: 14),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Pallete.errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Pallete.errorColor, width: 2),
      ),
    ),
  );
}
