import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:example/config/config.dart';
import 'package:example/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final appTheme = AppTheme(isDarkMode: false);

  runApp(
    ThemeProvider(
      initTheme: appTheme.getTheme(),
      builder: (context, theme) => MaterialApp(
        title: 'Rive Change Color Example',
        theme: theme,
        home: const HomeScreen(),
      ),
    ),
  );
}
