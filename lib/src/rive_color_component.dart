import 'dart:ui';

import 'package:rive/rive.dart';

/// Represents a color component of a Rive animation.
class RiveColorComponent {
  final String shapeName;
  final String? fillName;
  final Color color;
  final String? strokeName;

  Shape? shape;
  Fill? fill;
  Stroke? stroke;

  /// Creates a [RiveColorComponent].
  ///
  /// The [shapeName] is the name of the shape in the Rive animation.
  /// The [fillName] is the name of the fill in the shape. Either [fillName]
  /// or [strokeName] must be provided, but not both.
  /// The [color] is the color to be applied to the component.
  RiveColorComponent({
    required this.shapeName,
    this.fillName,
    this.strokeName,
    required this.color,
  }) : assert(fillName == null || strokeName == null,
            "Fill or stroke name must be provided, but not both");

  /// Overrides the equality operator for the [RiveColorComponent] class.
  ///
  /// Returns `true` if the [other] object is equal to this [RiveColorComponent]
  /// object, `false` otherwise.
  ///
  /// Two [RiveColorComponent] objects are considered equal if their [fillName],
  ///  [shapeName], [strokeName], and [color] properties are all equal.
  @override
  bool operator ==(covariant RiveColorComponent other) {
    if (identical(this, other)) return true;

    return other.fillName == fillName &&
        other.shapeName == shapeName &&
        other.strokeName == strokeName &&
        other.color == color;
  }

  /// Overrides the default hashCode getter to calculate the hash code based
  /// on the values of [fillName], [shapeName], [strokeName], and [color].
  @override
  int get hashCode {
    return fillName.hashCode ^
        shapeName.hashCode ^
        strokeName.hashCode ^
        color.hashCode;
  }
}
