import 'package:flutter/material.dart';

const pinkPrimaryColor = Color(0xFFff4080);

const pinkSecondaryColor = Color(0xFFFF92b6);

const pinkPrimaryVariantColor = Color(0xff263238);
const pinkSecondaryVariantColor = Color(0xff37474f);

const cyanPrimaryColor = Color(0xFF40C4FF);

const cyanSecondaryColor = Color(0xFFb1e5ff);

const cyanPrimaryVariantColor = Color(0xff263238);
const cyanSecondaryVariantColor = Color(0xff263238);

class CustomTheme {
  static ThemeData get pinkTheme {
    ThemeData theme = ThemeData.light();
    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            onPrimary: pinkPrimaryVariantColor,
            onSecondary: pinkSecondaryVariantColor,
            primary: pinkPrimaryColor,
            secondary: pinkSecondaryColor,
            primaryVariant: pinkPrimaryVariantColor,
            secondaryVariant: pinkSecondaryVariantColor,
            background: Colors.white),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: pinkSecondaryColor,
        ),
        textTheme: theme.textTheme.apply(
            displayColor: pinkPrimaryVariantColor,
            bodyColor: pinkPrimaryVariantColor));
  }

  static ThemeData get cyanTheme {
    ThemeData theme = ThemeData.light();
    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            onPrimary: cyanPrimaryVariantColor,
            onSecondary: cyanPrimaryVariantColor,
            primary: cyanPrimaryColor,
            secondary: cyanSecondaryColor,
            primaryVariant: cyanPrimaryVariantColor,
            secondaryVariant: cyanPrimaryVariantColor,
            background: Colors.white),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: cyanSecondaryColor,
        ),
        textTheme: theme.textTheme.apply(
            displayColor: cyanPrimaryVariantColor,
            bodyColor: cyanPrimaryVariantColor));
  }
}
