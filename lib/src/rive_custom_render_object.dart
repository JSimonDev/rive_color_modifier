import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:rive/math.dart' show Mat2D;
import 'package:rive/rive.dart';

import 'package:rive_color_modifier/src/rive_color_component.dart';

/// A custom Rive render object that taps into the draw method to modify colors.
class RiveCustomRenderObject extends RiveRenderObject {
  List<RiveColorComponent> _components = [];

  RiveCustomRenderObject(super.artboard);

  /// The list of [RiveColorComponent]s that define the color modifications to apply.
  List<RiveColorComponent> get components => _components;

  /// Setter method for the [components] property.
  /// Updates the list of [RiveColorComponent] objects and performs necessary operations.
  /// Throws exceptions if the required shapes, fills, or strokes are not found.
  /// Triggers a repaint of the widget.
  set components(List<RiveColorComponent> value) {
    if (listEquals(_components, value)) {
      return;
    }
    _components = value;

    for (final component in _components) {
      final shapePatternRegExp = RegExp(component.shapePattern);
      final shapes = artboard.objects.where(
        (object) => object is Shape && shapePatternRegExp.hasMatch(object.name),
      ) as List<Shape>;

      if (shapes.isEmpty) {
        throw Exception(
            "Could not find shape that matches: ${component.shapePattern}");
      }

      for (final shape in shapes) {
        var fills = <Fill>[];
        if (component.fillPattern != null) {
          final fillPatternRegExp = RegExp(component.fillPattern!);
          fills = shape.fills
              .where(
                (fill) => fillPatternRegExp.hasMatch(fill.name),
              )
              .toList();
        }

        var strokes = <Stroke>[];

        if (component.strokePattern != null) {
          final strokePatternRegExp = RegExp(component.strokePattern!);
          strokes = shape.strokes
              .where(
                (stroke) => strokePatternRegExp.hasMatch(stroke.name),
              )
              .toList();
        }

        component.shapeComponents.add(
          ShapeComponents(
            shape: shape,
            fill: fills,
            stroke: strokes,
          ),
        );
      }
    }

    markNeedsPaint();
  }

  /// Overrides the [draw] method of the parent class to change the colors of the components.
  ///
  /// This method iterates through the list of components and updates their fill or stroke colors
  /// based on the component's color and alpha value. If a component has both fill and stroke,
  /// the fill color will be updated. If a component has neither fill nor stroke, an exception
  /// will be thrown.
  ///
  /// After updating the colors, the method calls the [draw] method of the parent class to
  /// draw the components on the canvas.
  @override
  void draw(Canvas canvas, Mat2D viewTransform) {
    for (final component in _components) {
      for (final shapeComponent in component.shapeComponents) {
        for (final fill in shapeComponent.fill) {
          fill.paint.color = component.color.withAlpha(fill.paint.color.alpha);
        }

        for (final stroke in shapeComponent.stroke) {
          stroke.paint.color =
              component.color.withAlpha(stroke.paint.color.alpha);
        }
      }
    }

    super.draw(canvas, viewTransform);
  }
}
