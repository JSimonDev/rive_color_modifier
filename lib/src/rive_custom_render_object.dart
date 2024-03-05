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
      component.shape = artboard.objects.firstWhere(
        (object) => object is Shape && object.name == component.shapeName,
        orElse: () => null,
      ) as Shape?;

      if (component.shape != null &&
          component.fillName != null &&
          component.shape!.fills.isNotEmpty) {
        try {
          component.fill = component.shape!.fills.firstWhere(
            (fill) => fill.name == component.fillName,
          );
        } catch (e) {
          component.fill = null;
        }

        if (component.fill == null) {
          throw Exception(
            "Could not find fill named: ${component.fillName}",
          );
        }
      } else if (component.shape != null &&
          component.strokeName != null &&
          component.shape!.strokes.isNotEmpty) {
        try {
          component.stroke = component.shape!.strokes
              .firstWhere((stroke) => stroke.name == component.strokeName);
        } catch (e) {
          component.stroke = null;
        }

        if (component.stroke == null) {
          throw Exception(
            "Could not find stroke named: ${component.strokeName}",
          );
        }
      } else {
        throw Exception("Could not find shape named: ${component.shapeName}");
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
      if (component.fill != null) {
        component.fill!.paint.color =
            component.color.withAlpha(component.fill!.paint.color.alpha);
      } else if (component.stroke != null) {
        component.stroke!.paint.color =
            component.color.withAlpha(component.stroke!.paint.color.alpha);
      } else {
        throw Exception("Could not find fill or stroke for component");
      }
    }

    super.draw(canvas, viewTransform);
  }
}
