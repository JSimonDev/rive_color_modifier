import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:example/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A button that allows the user to switch between light and dark themes.
class ThemeSwitcherButton extends StatelessWidget {
  const ThemeSwitcherButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appThemeDark = AppTheme(isDarkMode: true).getTheme();
    final appThemeLight = AppTheme(isDarkMode: false).getTheme();

    return ThemeSwitcher.switcher(
      builder: (context, switcher) {
        return IconButton(
          iconSize: 50,
          icon: Icon(
            isDarkMode ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
          ),
          onPressed: () async {
            HapticFeedback.lightImpact();
            switcher.changeTheme(
              isReversed: isDarkMode ? true : false,
              theme: isDarkMode ? appThemeLight : appThemeDark,
            );
          },
        );
      },
    );
  }
}
