// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:rive/math.dart' show Mat2D;
import 'package:rive/rive.dart';
// ignore: implementation_imports
import 'package:rive/src/rive_core/shapes/paint/linear_gradient.dart'
    as rive_core;
// ignore: implementation_imports
import 'package:rive/src/rive_core/shapes/paint/radial_gradient.dart'
    as rive_core;
import 'package:rive_color_modifier/src/rive_color_component.dart';
import 'package:rive_color_modifier/src/rive_component.dart';
import 'package:rive_color_modifier/src/rive_gradient_component.dart';

/// A custom Rive render object that taps into the draw method to modify colors and gradients.
///
/// This class extends [RiveRenderObject] and provides functionality to modify
/// colors and gradients of shapes in a Rive animation at runtime.
///
/// Usage example:
/// ```dart
/// final customRenderObject = RiveCustomRenderObject(myArtboard);
/// customRenderObject.components = [
///   RiveColorComponent(
///     shapePattern: 'MyShape',
///     fillPattern: 'MyFill',
///     color: Colors.red,
///   ),
///   RiveGradientComponent(
///     shapePattern: 'MyGradientShape',
///     fillPattern: 'MyGradientFill',
///     colors: [Colors.blue, Colors.green],
///     stops: [0.0, 1.0],
///   ),
/// ];
/// ```
class RiveCustomRenderObject extends RiveRenderObject {
  List<RiveComponent> _components = [];
  bool _needsColorUpdate = true;

  /// Creates a [RiveCustomRenderObject] with the given [artboard].
  RiveCustomRenderObject(super.artboard);

  /// The list of [RiveComponent]s that define the color and gradient modifications to apply.
  List<RiveComponent> get components => _components;

  /// Sets the list of [RiveComponent]s for this custom render object.
  ///
  /// The [components] list is used to match shapes in the [artboard] based on their names and patterns.
  /// For each [RiveComponent] in the [components] list, this method finds the corresponding shapes in the [artboard]
  /// and adds them to the [shapeComponents] list of the [RiveComponent].
  ///
  /// If a shape cannot be found for a given [RiveComponent], an [Exception] is thrown with a descriptive error message.
  ///
  /// After updating the [components] list, this method calls [_prepareComponents()] to perform any necessary setup
  /// or calculations for the components.
  ///
  /// Finally, it marks the render object as needing to be repainted by calling [markNeedsPaint()].
  ///
  /// Throws:
  ///   - [Exception] if a shape cannot be found for a given [RiveComponent].
  ///
  /// See also:
  ///   - [RiveComponent], the class representing a component in the Rive animation.
  ///   - [Shape], the class representing a shape in the Rive animation.
  ///   - [Fill], the class representing a fill in a shape.
  ///   - [Stroke], the class representing a stroke in a shape.
  set components(List<RiveComponent> value) {
    if (listEquals(_components, value)) return;
    _components = value;
    _updateComponents();
    markNeedsPaint();
  }

  /// Updates the shapes for all components in the [_components] list.
  void _updateComponents() {
    for (final component in _components) {
      _updateComponentShapes(component);
    }
    _prepareComponents();
  }

  /// Updates the shapes for a single [RiveComponent].
  ///
  /// This method finds all shapes in the artboard that match the component's
  /// shape pattern and updates the component's [shapeComponents] list with
  /// the matching shapes, fills, and strokes.
  ///
  /// Throws an [Exception] if no matching shapes are found.
  void _updateComponentShapes(RiveComponent component) {
    final shapePatternRegExp = RegExp(component.shapePattern);
    final shapes = artboard.objects
        .whereType<Shape>()
        .where((shape) => shapePatternRegExp.hasMatch(shape.name))
        .toList();

    if (shapes.isEmpty) {
      throw Exception(
        "Could not find shape that matches: ${component.shapePattern}",
      );
    }

    component.shapeComponents.clear();

    for (final shape in shapes) {
      var fills = <Fill>[];
      var strokes = <Stroke>[];

      if (component.fillPattern != null) {
        final fillPatternRegExp = RegExp(component.fillPattern!);
        fills = shape.fills
            .where((fill) => fillPatternRegExp.hasMatch(fill.name))
            .toList();
      }

      if (component.strokePattern != null) {
        final strokePatternRegExp = RegExp(component.strokePattern!);
        strokes = shape.strokes
            .where((stroke) => strokePatternRegExp.hasMatch(stroke.name))
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

  /// Prepares the components for rendering.
  ///
  /// This method iterates through each component and its shape components,
  /// and prepares them for rendering based on their type (color or gradient).
  void _prepareComponents() {
    for (final component in _components) {
      for (final shapeComponent in component.shapeComponents) {
        if (component is RiveColorComponent) {
          _prepareColorComponent(component, shapeComponent);
        } else if (component is RiveGradientComponent) {
          _prepareGradientComponent(component, shapeComponent);
        }
      }
    }
  }

  /// Prepares a color component by applying the color to the fill and stroke paints.
  ///
  /// This method applies the color from the [component] to all fills and strokes
  /// in the [shapeComponent], while preserving the original alpha value.
  void _prepareColorComponent(
    RiveColorComponent component,
    ShapeComponents shapeComponent,
  ) {
    for (final fill in shapeComponent.fill) {
      fill.paint.color = component.color.withValues(alpha: fill.paint.color.a);
    }

    for (final stroke in shapeComponent.stroke) {
      stroke.paint.color =
          component.color.withValues(alpha: stroke.paint.color.a);
    }
  }

  /// Prepares a gradient component by updating the gradient stops with the colors defined in the component.
  ///
  /// This method updates the colors and stops of linear and radial gradients
  /// in the [shapeComponent] based on the [component]'s colors and stops.
  ///
  /// Throws:
  ///   - [Exception] if there are fewer colors or stops defined in the component
  ///     than in the shape's gradient.
  void _prepareGradientComponent(
    RiveGradientComponent component,
    ShapeComponents shapeComponent,
  ) {
    void updateGradient(dynamic gradient) {
      if (gradient is rive_core.LinearGradient ||
          gradient is rive_core.RadialGradient) {
        if (component.colors.length < gradient.gradientStops.length) {
          throw Exception(
            "Fewer colors have been defined in the gradient component than the number of colors in the shape's gradient.",
          );
        }
        if (component.stops != null &&
            component.stops!.isNotEmpty &&
            component.stops!.length < gradient.gradientStops.length) {
          throw Exception(
            "Fewer stops have been defined in the gradient component than the number of stops in the shape's gradient.",
          );
        }

        for (int i = 0; i < gradient.gradientStops.length; i++) {
          gradient.gradientStops[i].color = component.colors[i];
          if (component.stops != null && component.stops!.isNotEmpty) {
            gradient.gradientStops[i].position = component.stops![i];
          }
        }
      }
    }

    _updateGradient(shapeComponent, updateGradient);
  }

  /// Updates the gradient for a shape component.
  ///
  /// This method applies the [updateGradient] function to all linear and radial
  /// gradients in the fills and strokes of the [shapeComponent].
  void _updateGradient(
    ShapeComponents shapeComponent,
    void Function(dynamic) updateGradient,
  ) {
    for (final fill in shapeComponent.fill) {
      if (fill.paintMutator is rive_core.LinearGradient ||
          fill.paintMutator is rive_core.RadialGradient) {
        updateGradient(fill.paintMutator);
      }
    }

    for (final stroke in shapeComponent.stroke) {
      if (stroke.paintMutator is rive_core.LinearGradient ||
          stroke.paintMutator is rive_core.RadialGradient) {
        updateGradient(stroke.paintMutator);
      }
    }
  }

  /// Disposes of the RiveCustomRenderObject.
  ///
  /// This method clears the [_components] list and calls the superclass dispose method.
  @override
  void dispose() {
    _components.clear();
    super.dispose();
  }

  @override
  bool advance(double elapsedSeconds) {
    final result = super.advance(elapsedSeconds);
    _updateComponents();
    return result;
  }

  /// Overrides the [draw] method to handle exceptions during drawing.
  ///
  /// This method calls the superclass [draw] method and handles any exceptions
  /// that occur, logging detailed error messages and potentially taking recovery actions.
  ///
  /// Parameters:
  ///   - [canvas]: The canvas on which to draw the render object.
  ///   - [viewTransform]: The transformation matrix to apply to the render object.
  @override
  void draw(Canvas canvas, Mat2D viewTransform) {
    try {
      if (_needsColorUpdate) {
        _updateComponents();
        _needsColorUpdate = false;
      }
      super.draw(canvas, viewTransform);
    } catch (e, stackTrace) {
      _handleDrawError(e, stackTrace);
    }
  }

  /// Handles errors that occur during the drawing process.
  ///
  /// This method logs the error details and takes appropriate action based on the error type.
  ///
  /// Parameters:
  ///   - [error]: The caught error object.
  ///   - [stackTrace]: The stack trace associated with the error.
  void _handleDrawError(Object error, StackTrace stackTrace) {
    // Log the error and stack trace
    print('Error during Rive drawing: $error');
    print('Stack trace: $stackTrace');

    // Handle specific error types
    if (error is ArgumentError) {
      print('Invalid argument provided to Rive drawing method');
      // Potential recovery action: reset to default values
    } else if (error is StateError) {
      print('Rive render object is in an invalid state');
      // Potential recovery action: attempt to reset the render object state
    } else if (error is UnsupportedError) {
      print('Unsupported operation in Rive drawing');
      // Potential recovery action: fallback to a simpler drawing method
    } else {
      print('Unknown error occurred during Rive drawing');
    }

    // Attempt to recover or provide fallback behavior
    _attemptRecovery();
  }

  /// Attempts to recover from a drawing error.
  ///
  /// This method implements fallback behavior or attempts to reset the render object
  /// to a valid state after an error occurs.
  void _attemptRecovery() {
    // Reset components
    _components.clear();

    // Attempt to redraw with default settings
    try {
      // Create a new PictureRecorder and Canvas
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw the artboard on the canvas
      artboard.draw(canvas);

      // You might want to do something with the resulting picture here
      // For example, you could create an image from it:
      // final picture = recorder.endRecording();
      // picture.toImage(artboard.width.toInt(), artboard.height.toInt());
    } catch (e) {
      print('Recovery attempt failed: $e');
      // If recovery fails, mark the render object as needing layout
      // This will trigger a rebuild on the next frame
      markNeedsLayout();
    }
  }
}
