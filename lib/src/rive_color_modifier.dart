import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:rive_color_modifier/src/rive_color_component.dart';
import 'package:rive_color_modifier/src/rive_custom_render_object.dart';

/// A widget that modifies the colors of a Rive animation.
class RiveColorModifier extends LeafRenderObjectWidget {
  final Artboard artboard;
  final BoxFit fit;
  final Alignment alignment;
  final List<RiveColorComponent> components;

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

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RiveCustomRenderObject(artboard as RuntimeArtboard)
      ..artboard = artboard
      ..fit = fit
      ..alignment = alignment
      ..components = components;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RiveCustomRenderObject renderObject) {
    renderObject
      ..artboard = artboard
      ..fit = fit
      ..alignment = alignment
      ..components = components;
  }

  @override
  void didUnmountRenderObject(covariant RiveCustomRenderObject renderObject) {
    renderObject.dispose();
  }
}
