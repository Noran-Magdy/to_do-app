import 'package:calender_app/shared/components/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: blueColor,
    ),
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkBackgroundColor,
    ),
  );
}
