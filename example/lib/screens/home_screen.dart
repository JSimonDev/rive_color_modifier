import 'package:example/screens/rive_modify_color_screen.dart';
import 'package:example/screens/rive_modify_gradient_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Text(
                'rive_color_modifier',
                style: textStyles.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _ExamplePreviewCard(
              title: "Changes color dynamically!",
              description:
                  'Incididunt sunt laborum ipsum excepteur cillum qui et incididunt incididunt incididunt ipsum eu velit.',
              imageUrl: 'assets/images/colors.jpg',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RiveModifyColorScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _ExamplePreviewCard(
              title: "Modify the linear and radial gradients too!",
              description:
                  'Incididunt sunt laborum ipsum excepteur cillum qui et incididunt incididunt incididunt ipsum eu velit.',
              imageUrl: 'assets/images/gradient.jpg',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RiveModifyGradientScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ExamplePreviewCard extends StatelessWidget {
  const _ExamplePreviewCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  final String title;
  final String description;
  final String imageUrl;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: colors.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        color: colors.surface,
        elevation: 0,
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(12.0) - const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Text(
                    title,
                    style: textStyles.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: textStyles.bodyLarge,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 15);

    const waveHeight = 20.0;
    const waveCount = 5;

    for (int i = 0; i < waveCount; i++) {
      final waveWidth = size.width / waveCount;
      final waveStart = i * waveWidth;

      path.cubicTo(
        waveStart + waveWidth * 0.25,
        size.height - waveHeight * 2,
        waveStart + waveWidth * 0.75,
        size.height,
        waveStart + waveWidth,
        size.height - waveHeight,
      );
    }

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
