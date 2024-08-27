import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:example/widgets/theme_switcher_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;
import 'package:rive_color_modifier/rive_color_modifier.dart';

/// A Flutter screen that demonstrates how to change gradients color in a Rive animation.
class RiveModifyGradientScreen extends StatefulWidget {
  const RiveModifyGradientScreen({super.key});

  @override
  State<RiveModifyGradientScreen> createState() =>
      _RiveModifyGradientScreenState();
}

class _RiveModifyGradientScreenState extends State<RiveModifyGradientScreen> {
  rive.Artboard? _messageArtboard;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _load());
  }

  /// Loads the message Rive file and initializes the necessary components.
  Future<void> _load() async {
    //* LOAD MESSAGE RIVE FILE
    final data = await rootBundle.load('assets/rive/message_icon.riv');
    await rive.RiveFile.initialize();
    final file = rive.RiveFile.import(data);
    final artboard = file.mainArtboard;
    artboard.addController(rive.SimpleAnimation('Animation 1'));

    _messageArtboard = artboard;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //* LIGHT MODE MESSAGE SHADOW STOPS
    const Color lMessageStop1 = Color.fromARGB(100, 255, 26, 105);
    const Color lMessageStop2 = Color.fromARGB(0, 255, 26, 105);

    const Color dMessageStop1 = Color.fromARGB(100, 59, 8, 148);
    const Color dMessageStop2 = Color.fromARGB(0, 59, 8, 148);

    //* LIGHT MODE BACKGROUND STOPS
    const Color lBackgroundStop1 = Color.fromARGB(255, 247, 149, 183);
    const Color lBackgroundStop2 = Color.fromARGB(255, 255, 26, 105);

    //* DARK MODE BACKGROUND STOPS
    const Color dBackgroundStop1 = Color.fromARGB(255, 103, 58, 183);
    const Color dBackgroundStop2 = Color.fromARGB(255, 33, 150, 243);

    //* LIGHT MODE SHADOW STOPS
    const Color lShadowStop1 = Color.fromARGB(255, 138, 13, 56);
    const Color lShadowStop2 = Color.fromARGB(155, 183, 18, 75);
    const Color lShadowStop3 = Color.fromARGB(97, 209, 20, 86);
    const Color lShadowStop4 = Color.fromARGB(0, 255, 26, 105);

    //* DARK MODE SHADOW STOPS
    const Color dShadowStop1 = Color.fromARGB(255, 59, 8, 148);
    const Color dShadowStop2 = Color.fromARGB(155, 59, 8, 148);
    const Color dShadowStop3 = Color.fromARGB(97, 59, 8, 148);
    const Color dShadowStop4 = Color.fromARGB(0, 59, 8, 148);

    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(),
        body: _messageArtboard != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      child: RiveColorModifier(
                        artboard: _messageArtboard!,
                        components: [
                          //* MESSAGE COLOR
                          RiveColorComponent(
                            shapePattern: '.*Message',
                            fillPattern: '.*',
                            color: !isDarkMode ? Colors.white : Colors.black,
                          ),
                          RiveGradientComponent(
                            shapePattern: '.*Message',
                            fillPattern: '.*',
                            colors: isDarkMode
                                ? [
                                    dMessageStop1,
                                    dMessageStop2,
                                  ]
                                : [
                                    lMessageStop1,
                                    lMessageStop2,
                                  ],
                          ),
                          //* MESSAGE SHADOW GRADIENT COLOR
                          RiveGradientComponent(
                            shapePattern: '.*Shadow',
                            fillPattern: '.*',
                            stops: [0, 0.3, 0.6, 1],
                            colors: isDarkMode
                                ? [
                                    dShadowStop1,
                                    dShadowStop2,
                                    dShadowStop3,
                                    dShadowStop4,
                                  ]
                                : [
                                    lShadowStop1,
                                    lShadowStop2,
                                    lShadowStop3,
                                    lShadowStop4,
                                  ],
                          ),
                          //* BACKGROUND GRADIENT COLOR
                          RiveGradientComponent(
                            shapePattern: '.*Background',
                            fillPattern: '.*',
                            colors: isDarkMode
                                ? [
                                    dBackgroundStop1,
                                    dBackgroundStop2,
                                  ]
                                : [
                                    lBackgroundStop1,
                                    lBackgroundStop2,
                                  ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ThemeSwitcherButton(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
