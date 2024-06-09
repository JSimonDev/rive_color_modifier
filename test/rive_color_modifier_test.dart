import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rive/rive.dart';
import 'package:rive_color_modifier/rive_color_modifier.dart';

void main() {
  group('RiveColorComponent Tests', () {
    test('RiveColorComponent creation test', () {
      const color = Color(0xFFFFFFFF);
      var component = RiveColorComponent(
        shapePattern: 'shape',
        fillPattern: 'fill',
        color: color,
      );

      expect(component.shapePattern, 'shape');
      expect(component.fillPattern, 'fill');
      expect(component.color, color);
      expect(component.strokePattern, null);
    });

    test('RiveColorComponent creation with strokeName test', () {
      const color = Color(0xFFFFFFFF);
      var component = RiveColorComponent(
        shapePattern: 'shape',
        strokePattern: 'stroke',
        color: color,
      );

      expect(component.shapePattern, 'shape');
      expect(component.strokePattern, 'stroke');
      expect(component.color, color);
      expect(component.fillPattern, null);
    });

    test(
        'RiveColorComponent creation with both fillName and strokeName throws AssertionError',
        () {
      const color = Color(0xFFFFFFFF);
      expect(
          () => RiveColorComponent(
                shapePattern: 'shape',
                fillPattern: 'fill',
                strokePattern: 'stroke',
                color: color,
              ),
          throwsA(isA<AssertionError>()));
    });

    test('RiveColorComponent equality test', () {
      const color = Color(0xFFFFFFFF);
      var component1 = RiveColorComponent(
        shapePattern: 'shape',
        fillPattern: 'fill',
        color: color,
      );

      var component2 = RiveColorComponent(
        shapePattern: 'shape',
        fillPattern: 'fill',
        color: color,
      );

      expect(component1, component2);
    });
  });

  group('RiveColorModifier Tests', () {
    test('RiveColorModifier creation test', () {
      final artboard = Artboard();
      final components = <RiveColorComponent>[];

      var modifier = RiveColorModifier(
        artboard: artboard,
        components: components,
      );

      expect(modifier.artboard, artboard);
      expect(modifier.fit, BoxFit.contain);
      expect(modifier.alignment, Alignment.center);
      expect(modifier.components, components);
    });

    test('RiveColorModifier creation with custom fit and alignment', () {
      final artboard = Artboard();
      final components = <RiveColorComponent>[];

      var modifier = RiveColorModifier(
        artboard: artboard,
        fit: BoxFit.fill,
        alignment: Alignment.topLeft,
        components: components,
      );

      expect(modifier.artboard, artboard);
      expect(modifier.fit, BoxFit.fill);
      expect(modifier.alignment, Alignment.topLeft);
      expect(modifier.components, components);
    });
  });
}
