import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.lightBlue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orangeAccent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black12,
      selectedItemColor: HexColor('7856FF'),
      unselectedItemColor: Colors.grey,
      elevation: 20),
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      color: HexColor('15202B'),
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
  scaffoldBackgroundColor: HexColor('15202B'),
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
);
ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.green,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.green,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: HexColor('7856FF'),
      elevation: 20),
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
  scaffoldBackgroundColor: Colors.white,
);
