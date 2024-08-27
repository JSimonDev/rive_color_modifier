import 'package:flutter/material.dart';

/// Represents the theme of the application.
class AppTheme {
  final bool isDarkMode;

  /// Constructs a new instance of [AppTheme].
  ///
  /// The [isDarkMode] parameter determines whether the theme is in dark mode or light mode.
  AppTheme({
    required this.isDarkMode,
  });

  /// Returns the theme data based on the current configuration.
  ThemeData getTheme() => ThemeData(
        ///* General
        colorSchemeSeed: Colors.deepPurple,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: 'AirbnbCereal',
      );

  /// Creates a copy of this [AppTheme] instance with the specified properties overridden.
  ///
  /// The [selectedColor] parameter is optional and represents the selected color.
  /// The [isDarkMode] parameter is optional and determines whether the theme is in dark mode or light mode.
  AppTheme copyWith({String? selectedColor, bool? isDarkMode}) => AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
