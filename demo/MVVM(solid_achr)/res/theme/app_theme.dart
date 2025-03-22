import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_admin/res/theme/colors.dart';

ThemeData themeData(BuildContext context) => ThemeData(
      primaryColor: ColorsValue.primaryColor,
      textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF0F5FA),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    );

ThemeData darkThemeData(BuildContext context) => ThemeData(
      primaryColor: ColorsValue.primaryColor,
      textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF0F5FA),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    );
