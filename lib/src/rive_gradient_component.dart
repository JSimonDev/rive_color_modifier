import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive_color_modifier/src/rive_component.dart';

/// Represents a Gradient component of a Rive animation.
///
/// This class implements the [RiveComponent] interface and provides
/// functionality to apply a gradient to specific elements in a Rive animation.
/// It allows targeting either the fill or stroke of a shape within the animation.
///
/// Usage example:
/// ```dart
/// final rainbowGradient = RiveGradientComponent(
///   shapePattern: 'MyShape',
///   fillPattern: 'MyFill',
///   colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple],
///   stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
/// );
/// ```
class RiveGradientComponent implements RiveComponent {
  /// The pattern to match the shape name in the Rive animation.
  ///
  /// This can be an exact name or a regular expression pattern.
  /// For example: 'MyShape' or r'Shape\d+'
  @override
  final String shapePattern;

  /// The pattern to match the fill name in the shape.
  ///
  /// This can be null if [strokePattern] is provided instead.
  /// When non-null, it targets the fill of the matched shape.
  @override
  final String? fillPattern;

  /// The pattern to match the stroke name in the shape.
  ///
  /// This can be null if [fillPattern] is provided instead.
  /// When non-null, it targets the stroke of the matched shape.
  @override
  final String? strokePattern;

  /// A list of shape components that match the specified patterns.
  ///
  /// This list is populated during the gradient application process and
  /// contains all the shapes that match the [shapePattern] along with
  /// their respective fill or stroke that matches [fillPattern] or [strokePattern].
  @override
  List<ShapeComponents> shapeComponents = [];

  /// The list of colors to be used in the gradient.
  ///
  /// This list should contain at least two colors to create a gradient effect.
  final List<Color> colors;

  /// The list of color stops for the gradient.
  ///
  /// Each stop is a value between 0.0 and 1.0 indicating the position of the
  /// corresponding color in the gradient. If null, the colors will be evenly distributed.
  final List<double>? stops;

  /// Creates a [RiveGradientComponent].
  ///
  /// [shapePattern] is required and specifies the name pattern of the shape in the Rive animation.
  /// Either [fillPattern] or [strokePattern] must be provided, but not both.
  /// [colors] is required and specifies the list of colors to be used in the gradient.
  /// [stops] is optional and specifies the positions of each color in the gradient.
  ///
  /// Throws an [AssertionError] if both [fillPattern] and [strokePattern] are null or non-null,
  /// or if [colors] contains fewer than two colors.
  ///
  /// Example:
  /// ```dart
  /// final blueToRedGradient = RiveGradientComponent(
  ///   shapePattern: 'Circle',
  ///   strokePattern: '.*',
  ///   colors: [Colors.blue, Colors.red],
  ///   stops: [0.0, 1.0],
  /// );
  /// ```
  RiveGradientComponent({
    required this.shapePattern,
    this.fillPattern,
    this.strokePattern,
    required this.colors,
    this.stops,
  })  : assert(
          (fillPattern == null) != (strokePattern == null),
          'Either fillPattern or strokePattern must be provided, but not both.',
        ),
        assert(
          colors.length >= 2,
          'At least two colors must be provided to create a gradient.',
        ),
        assert(
          stops == null || stops.length == colors.length,
          'If provided, stops must have the same length as colors.',
        );

  /// Determines if this [RiveGradientComponent] is equal to another object.
  ///
  /// Returns true if the [other] object is a [RiveGradientComponent] with the same
  /// [shapePattern], [fillPattern], [strokePattern], [colors], and [stops].
  ///
  /// This method is useful for comparing two [RiveGradientComponent] instances
  /// to check if they represent the same gradient modification.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RiveGradientComponent &&
        other.shapePattern == shapePattern &&
        other.fillPattern == fillPattern &&
        other.strokePattern == strokePattern &&
        listEquals(other.colors, colors) &&
        listEquals(other.stops, stops);
  }

  /// Generates a hash code for this [RiveGradientComponent].
  ///
  /// The hash code is based on the [shapePattern], [fillPattern], [strokePattern],
  /// [colors], and [stops].
  /// This ensures that instances with the same values will have the same hash code,
  /// which is important for proper behavior when used in hash-based collections.
  @override
  int get hashCode =>
      shapePattern.hashCode ^
      fillPattern.hashCode ^
      strokePattern.hashCode ^
      Object.hashAll(colors) ^
      (stops != null ? Object.hashAll(stops!) : 0);
}
