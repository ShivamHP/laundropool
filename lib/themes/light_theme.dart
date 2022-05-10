import 'package:flutter/material.dart';
import 'package:laundropool/values/colors.dart';

ThemeData AppLightTheme() {
  return ThemeData(
    canvasColor: Colors.white,
    primaryColor: AppColors().primaryColor,
    fontFamily: 'Lato',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white)
      ),
    ),
  );
}
