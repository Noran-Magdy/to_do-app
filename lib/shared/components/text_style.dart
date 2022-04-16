import 'package:calender_app/shared/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

TextStyle subHeaderStyle({
  Color? color,
}) {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

TextStyle headerStyle({
  Color? color,
}) {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

TextStyle textButtonStyle() {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      color: whiteColor,
      fontSize: 16,
    ),
  );
}

TextStyle titleStyle() {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? whiteColor : darkBackgroundColor,
      fontSize: 17,
    ),
  );
}

TextStyle formFieldStyle() {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
      fontSize: 15,
    ),
  );
}
