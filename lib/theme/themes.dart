import 'package:flutter/material.dart';
import 'package:launcher_gf101/theme/color_schemes.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  // Add other theme properties like textTheme, appBarTheme etc.
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  brightness: Brightness.dark,
  // Add other theme properties
);
