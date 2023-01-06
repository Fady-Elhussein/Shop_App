import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white12,
  appBarTheme: const AppBarTheme(
    color: Colors.white12,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white60,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white12,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.white60,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.blue,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white12,
    unselectedItemColor: Colors.white60,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.amberAccent,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Colors.white12,
    labelStyle: TextStyle(color: Colors.amberAccent),
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.blue),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.black),
  ),

  fontFamily: 'Jannah',
);
