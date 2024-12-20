// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields
import 'dart:ui';

import 'package:rive_color_modifier/src/rive_component.dart';

/// Represents a color component of a Rive animation.
///
/// This class implements the [RiveComponent] interface and provides
/// functionality to modify the color of specific elements in a Rive animation.
/// It allows targeting either the fill or stroke of a shape within the animation.
///
/// Usage example:
/// ```dart
/// final redFill = RiveColorComponent(
///   shapePattern: 'MyShape',
///   fillPattern: 'MyFill',
///   color: Colors.red,
/// );
/// ```
class RiveColorComponent implements RiveComponent {
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

  /// The color to be applied to the matched component.
  ///
  /// This color will replace the original color of the matched fill or stroke.
  final Color color;

  /// A list of shape components that match the specified patterns.
  ///
  /// This list is populated during the color modification process and
  /// contains all the shapes that match the [shapePattern] along with
  /// their respective fill or stroke that matches [fillPattern] or [strokePattern].
  @override
  List<ShapeComponents> shapeComponents = [];

  /// Creates a [RiveColorComponent].
  ///
  /// [shapePattern] is required and specifies the name pattern of the shape in the Rive animation.
  /// Either [fillPattern] or [strokePattern] must be provided, but not both.
  /// [color] is required and specifies the color to be applied to the component.
  ///
  /// Throws an [AssertionError] if both [fillPattern] and [strokePattern] are null or non-null.
  ///
  /// Example:
  /// ```dart
  /// final blueStroke = RiveColorComponent(
  ///   shapePattern: 'Circle',
  ///   strokePattern: 'Outline',
  ///   color: Colors.blue,
  /// );
  /// ```
  RiveColorComponent({
    required this.shapePattern,
    this.fillPattern,
    this.strokePattern,
    required this.color,
  });

  /// Determines if this [RiveColorComponent] is equal to another object.
  ///
  /// Returns true if the [other] object is a [RiveColorComponent] with the same
  /// [fillPattern], [shapePattern], [strokePattern], and [color].
  ///
  /// This method is useful for comparing two [RiveColorComponent] instances
  /// to check if they represent the same color modification.
  @override
  bool operator ==(covariant RiveColorComponent other) {
    if (identical(this, other)) return true;

    return other.fillPattern == fillPattern &&
        other.shapePattern == shapePattern &&
        other.strokePattern == strokePattern &&
        other.color == color;
  }

  /// Generates a hash code for this [RiveColorComponent].
  ///
  /// The hash code is based on the [fillPattern], [shapePattern], [strokePattern], and [color].
  /// This ensures that instances with the same values will have the same hash code,
  /// which is important for proper behavior when used in hash-based collections.
  @override
  int get hashCode {
    return fillPattern.hashCode ^
        shapePattern.hashCode ^
        strokePattern.hashCode ^
        color.hashCode;
  }
}
