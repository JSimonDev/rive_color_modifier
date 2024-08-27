import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:rive_color_modifier/src/rive_color_component.dart';
import 'package:rive_color_modifier/src/rive_component.dart';
import 'package:rive_color_modifier/src/rive_custom_render_object.dart';

/// A widget that modifies the colors of a Rive animation.
class RiveColorModifier extends LeafRenderObjectWidget {
  final Artboard artboard;
  final BoxFit fit;
  final Alignment alignment;
  final List<RiveComponent> components;

  /// Creates a [RiveColorModifier].
  ///
  /// The [artboard] is the Rive animation to modify.
  /// The [fit] determines how the animation is fitted into the widget.
  /// The [alignment] determines the alignment of the animation within the widget.
  /// The [components] is a list of [RiveColorComponent]s that define the color modifications to apply.
  const RiveColorModifier({
    super.key,
    required this.artboard,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.components = const [],
  });

  /// Creates a render object for the RiveColorModifier widget.
  ///
  /// This method is called when a new instance of the widget is created and
  /// needs to create the corresponding render object. It returns a new instance
  /// of the RiveCustomRenderObject with the specified properties.
  ///
  /// The [context] parameter provides the build context for the widget.
  ///
  /// Returns the created render object.
  @override
  RiveCustomRenderObject createRenderObject(BuildContext context) {
    return RiveCustomRenderObject(artboard as RuntimeArtboard)
      ..fit = fit
      ..alignment = alignment
      ..components = components;
  }

  /// Updates the render object with the specified parameters.
  ///
  /// This method is called when the widget needs to update its associated
  /// render object. It sets the properties of the render object based on the
  /// current values of the widget's properties.
  ///
  /// The [context] parameter is the build context of the widget.
  /// The [renderObject] parameter is the render object to be updated.
  @override
  void updateRenderObject(
    BuildContext context,
    RiveCustomRenderObject renderObject,
  ) {
    renderObject
      ..artboard = artboard
      ..fit = fit
      ..alignment = alignment
      ..components = components;
  }
}
