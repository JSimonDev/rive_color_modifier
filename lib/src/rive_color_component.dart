// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:rive/rive.dart';

/// Represents a color component of a Rive animation.
class RiveColorComponent {
  final String shapePattern;
  final String? fillPattern;
  final String? strokePattern;
  final Color color;

  List<ShapeComponents> shapeComponents = [];

  /// Creates a [RiveColorComponent].
  ///
  /// The [shapePattern] is the name of the shape in the Rive animation.
  /// The [fillPattern] is the name of the fill in the shape. Either [fillPattern]
  /// or [strokePattern] must be provided, but not both.
  /// The [color] is the color to be applied to the component.
  RiveColorComponent({
    required this.shapePattern,
    this.fillPattern,
    this.strokePattern,
    required this.color,
  }) : assert(fillPattern == null || strokePattern == null,
            "Fill or stroke name must be provided, but not both");

  /// Overrides the equality operator for the [RiveColorComponent] class.
  ///
  /// Returns `true` if the [other] object is equal to this [RiveColorComponent]
  /// object, `false` otherwise.
  ///
  /// Two [RiveColorComponent] objects are considered equal if their [fillPattern],
  ///  [shapePattern], [strokePattern], and [color] properties are all equal.
  @override
  bool operator ==(covariant RiveColorComponent other) {
    if (identical(this, other)) return true;

    return other.fillPattern == fillPattern &&
        other.shapePattern == shapePattern &&
        other.strokePattern == strokePattern &&
        other.color == color;
  }

  /// Overrides the default hashCode getter to calculate the hash code based
  /// on the values of [fillPattern], [shapePattern], [strokePattern], and [color].
  @override
  int get hashCode {
    return fillPattern.hashCode ^
        shapePattern.hashCode ^
        strokePattern.hashCode ^
        color.hashCode;
  }
}

class ShapeComponents {
  ShapeComponents({
    required this.shape,
    required this.fill,
    required this.stroke,
  });

  final Shape shape;
  final List<Fill> fill;
  final List<Stroke> stroke;
}
