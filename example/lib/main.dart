import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:rive_color_modifier/rive_color_modifier.dart';

void main() {
  final appTheme = AppTheme(isDarkMode: false);

  runApp(
    ThemeProvider(
      initTheme: appTheme.getTheme(),
      builder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rive Change Color Example',
        theme: theme,
        home: const RiveChangeColorExampleApp(),
      ),
    ),
  );
}

/// A Flutter app that demonstrates how to change colors in a Rive animation.
class RiveChangeColorExampleApp extends StatefulWidget {
  const RiveChangeColorExampleApp({super.key});

  @override
  State<RiveChangeColorExampleApp> createState() =>
      _RiveChangeColorExampleAppState();
}

/// The state class for the RiveChangeColorExampleApp widget.
class _RiveChangeColorExampleAppState extends State<RiveChangeColorExampleApp> {
  late Artboard _avatarArtboard;
  late SMIBool hoverBoolean;

  //* DEFAULT COLORS
  Color dBackgroundColor = const Color(0xff6C45B6);
  Color dSkinColor = const Color(0xff9F6145);
  Color dBandanaColor = const Color(0xffFF5A0D);
  Color dBandanaLinesColor = const Color(0xffFF720D);
  Color dEyeColor = Colors.black;
  Color dHairColor = const Color(0xff2C1523);
  Color dEyebrowColor = const Color(0xff884A33);
  Color dNoseColor = const Color(0xff884A33);
  Color dMouthColor = const Color(0xff884A33);
  Color dEarringColor = const Color(0xffFF9F00);
  Color dOverallColor = const Color(0xff62D5C6);
  Color dPocketColor = const Color(0xff4EADB0);
  Color dButtonColor = const Color(0xffFF5A0D);
  Color dButtonThreadColor = const Color(0xff4B1818);

  //* VARIATION COLORS
  Color vBackgroundColor = const Color.fromARGB(255, 208, 136, 12);
  Color vSkinColor = const Color(0xffFFD6A0);
  Color vBandanaColor = const Color.fromARGB(255, 76, 155, 225);
  Color vBandanaLinesColor = const Color.fromARGB(255, 85, 176, 255);
  Color vEyeColor = const Color.fromARGB(255, 94, 45, 7);
  Color vHairColor = const Color.fromARGB(255, 182, 65, 19);
  Color vEyebrowColor = const Color.fromARGB(255, 182, 116, 90);
  Color vNoseColor = const Color.fromARGB(255, 212, 180, 137);
  Color vMouthColor = const Color.fromARGB(255, 212, 180, 137);
  Color vEarringColor = const Color.fromARGB(255, 98, 182, 254);
  Color vOverallColor = const Color.fromARGB(255, 122, 78, 205);
  Color vPocketColor = const Color.fromARGB(255, 81, 53, 144);
  Color vButtonColor = const Color.fromARGB(255, 76, 155, 225);
  Color vButtonThreadColor = const Color.fromARGB(255, 92, 67, 149);

  /// Loads the avatar Rive file and initializes the necessary components.
  Future<void> _load() async {
    //* LOAD AVATAR RIVE FILE
    final avatarFile = await RiveFile.asset('assets/avatar.riv');
    final artboard = avatarFile.artboardByName('Avatar')!;
    StateMachineController controller = RiveUtils.getRiveController(
      artboard,
      stateMachineName: 'AVATAR_Interactivity',
    );

    hoverBoolean = controller.findSMI('Hover/Select') as SMIBool;

    setState(
      () {
        _avatarArtboard = artboard;
      },
    );
  }

  void onTap() {
    hoverBoolean.change(true);
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        hoverBoolean.change(false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ThemeSwitchingArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTap: onTap,
                child: RiveColorModifier(
                  artboard: _avatarArtboard,
                  components: [
                    //* BACKGROUND COLOR
                    RiveColorComponent(
                      shapePattern: '.*Background',
                      fillPattern: '.*',
                      color: isDarkMode ? vBackgroundColor : dBackgroundColor,
                    ),
                    //* SKIN COLOR
                    RiveColorComponent(
                      shapePattern: '.*Skin',
                      fillPattern: '.*',
                      strokePattern: '.*',
                      color: isDarkMode ? vSkinColor : dSkinColor,
                    ),
                    //* HAIR COLOR
                    RiveColorComponent(
                      shapePattern: '.*Hair',
                      fillPattern: '.*',
                      color: isDarkMode ? vHairColor : dHairColor,
                    ),
                    //* BANDANA COLOR
                    RiveColorComponent(
                      shapePattern: '.*Bandana',
                      fillPattern: '.*',
                      color: isDarkMode ? vBandanaColor : dBandanaColor,
                    ),
                    //* BANDANA LINES COLOR
                    RiveColorComponent(
                      shapePattern: '.*Bandana Lines',
                      strokePattern: '.*',
                      color:
                          isDarkMode ? vBandanaLinesColor : dBandanaLinesColor,
                    ),
                    //* EYEBROW COLOR
                    RiveColorComponent(
                      shapePattern: '.*Eyebrow',
                      strokePattern: '.*',
                      color: isDarkMode ? vEyebrowColor : dEyebrowColor,
                    ),
                    //* EYE COLOR
                    RiveColorComponent(
                      shapePattern: '.*Pupil',
                      fillPattern: '.*',
                      color: isDarkMode ? vEyeColor : dEyeColor,
                    ),
                    //* CLOSED EYE && MOUTH COLOR
                    RiveColorComponent(
                      shapePattern: '.*(Eye Closed|Mouth)\$',
                      strokePattern: '.*',
                      color: isDarkMode ? vMouthColor : dMouthColor,
                    ),
                    //* NOSE COLOR
                    RiveColorComponent(
                      shapePattern: '.*Nose',
                      fillPattern: '.*',
                      color: isDarkMode ? vNoseColor : dNoseColor,
                    ),
                    //* EARRING COLOR
                    RiveColorComponent(
                      shapePattern: '.*Earring',
                      fillPattern: '.*',
                      color: isDarkMode ? vEarringColor : dEarringColor,
                    ),
                    //* OVERALL COLOR
                    RiveColorComponent(
                      shapePattern: '.*Overall',
                      fillPattern: '.*',
                      color: isDarkMode ? vOverallColor : dOverallColor,
                    ),
                    //* POCKET COLOR
                    RiveColorComponent(
                      shapePattern: '.*Pocket',
                      strokePattern: '.*',
                      color: isDarkMode ? vPocketColor : dPocketColor,
                    ),
                    //* BUTTON COLOR
                    RiveColorComponent(
                      shapePattern: '.*Button',
                      fillPattern: '.*',
                      color: isDarkMode ? vButtonColor : dButtonColor,
                    ),
                    //* BUTTON THREAD COLOR
                    RiveColorComponent(
                      shapePattern: 'Thread',
                      strokePattern: '.*',
                      color:
                          isDarkMode ? vButtonThreadColor : dButtonThreadColor,
                    ),
                    RiveColorComponent(
                      shapePattern: 'Thread',
                      strokePattern: '.*',
                      color:
                          isDarkMode ? vButtonThreadColor : dButtonThreadColor,
                    ),
                  ],
                ),
              ),
            ),
            const ThemeSwitcherButton(),
          ],
        ),
      ),
    );
  }
}

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

/// A utility class for working with Rive animations.
class RiveUtils {
  /// Retrieves a [StateMachineController] for the specified [artboard].
  ///
  /// The [stateMachineName] parameter is optional and defaults to 'State Machine 1'.
  /// If the [stateMachineName] is not found in the [artboard], null is returned.
  ///
  /// After retrieving the controller, it is added to the [artboard] and returned.
  static StateMachineController getRiveController(
    Artboard artboard, {
    stateMachineName = 'State Machine 1',
  }) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );

    artboard.addController(controller!);
    return controller;
  }
}

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
      );

  /// Creates a copy of this [AppTheme] instance with the specified properties overridden.
  ///
  /// The [selectedColor] parameter is optional and represents the selected color.
  /// The [isDarkMode] parameter is optional and determines whether the theme is in dark mode or light mode.
  AppTheme copyWith({String? selectedColor, bool? isDarkMode}) => AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
