import 'package:flutter/material.dart';

class AppTheme {
  static get appTheme => ThemeData(
        colorScheme: colorScheme,
        primarySwatch: getColor,
        fontFamily: 'Avenir',
        accentColor: primaryColor,
        cursorColor: Colors.black,
        textTheme: TextTheme(
          title: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 18),
          headline: TextStyle(fontWeight: FontWeight.w900),
          body1: TextStyle(fontWeight: FontWeight.w600),
          button: TextStyle(fontWeight: FontWeight.w800),
          caption: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Colors.grey
            // color: Color(0xFF222222).withOpacity(0.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 150,
          padding: EdgeInsets.symmetric(vertical: 16),
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent),
        cardTheme: CardTheme(
          color: accentColor,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  static final Color primaryColor = Color(0xFF53905F);
  static final Color accentColor = Color(0xFFECF3EE);
  static final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: accentColor,
  );

  static MaterialColor get getColor {
    Color color = primaryColor;
    Map<int, Color> colorMap = {
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color
    };
    return MaterialColor(0xFFECF3EE, colorMap);
  }
}
