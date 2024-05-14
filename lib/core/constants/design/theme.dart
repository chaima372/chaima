import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    primaryColor: Color(0xFF1976D2),

    // Color(0xFF1976D2),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1976D2),
      //Color.fromRGBO(216, 81, 45, 1.0),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF1976D2),
      shape: CircleBorder(
        eccentricity: 0.9,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        outlineBorder: BorderSide.none,
        border: InputBorder.none,
        iconColor: Color(0xFF1976D2),
        suffixIconColor: Color(0xFF1976D2),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16, color: Colors.black),
      bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
      subtitle1: TextStyle(fontSize: 16),
      subtitle2: TextStyle(fontSize: 14, color: Colors.grey),
      button: TextStyle(fontSize: 16, color: Colors.white),
      caption: TextStyle(fontSize: 12, color: Colors.grey),
      overline: TextStyle(fontSize: 10, color: Colors.grey),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: Colors.blue),
      unselectedIconTheme: IconThemeData(color: Colors.black),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
    ),
    drawerTheme: DrawerThemeData(
      shadowColor: Colors.blueGrey,
      backgroundColor: Color(0xFF1976D2), // Bleu principal
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF1976D2),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900], // Gris foncé pour le thème sombre
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    // Autres ajustements de couleurs...
    cardTheme: CardTheme(
      color: Colors.grey[800],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF1976D2), // Bleu principal
      shape: CircleBorder(
        eccentricity: 0.9,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        outlineBorder: BorderSide.none,
        border: InputBorder.none,
        iconColor: Color(0xFF1976D2), // Bleu principal
        suffixIconColor: Color(0xFF1976D2), // Bleu principal
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
      subtitle1: TextStyle(fontSize: 16),
      subtitle2: TextStyle(fontSize: 14, color: Colors.grey),
      button: TextStyle(fontSize: 16, color: Colors.white),
      caption: TextStyle(fontSize: 12, color: Colors.grey),
      overline: TextStyle(fontSize: 10, color: Colors.grey),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: Colors.blue),
      unselectedIconTheme: IconThemeData(color: Colors.black),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[900],
      shadowColor: Colors.grey[900],
    ),
  );
}
