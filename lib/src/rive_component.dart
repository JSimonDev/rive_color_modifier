import 'package:rive/rive.dart';

abstract class RiveComponent {
  String get shapePattern;
  String? get fillPattern;
  String? get strokePattern;
  List<ShapeComponents> get shapeComponents;
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
