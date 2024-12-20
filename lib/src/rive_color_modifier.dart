import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_color_modifier/src/rive_color_component.dart';
import 'package:rive_color_modifier/src/rive_component.dart';
import 'package:rive_color_modifier/src/rive_custom_render_object.dart';

/// A widget that modifies the colors of a Rive animation.
class RiveColorModifier extends LeafRenderObjectWidget {
  /// A widget that displays a Rive artboard with color modification capabilities.
  ///
  /// This widget extends Rive's functionality by allowing dynamic color modifications
  /// to specific components within the animation.
  ///
  /// Parameters:
  /// * [artboard] - The artboard to display and modify.
  /// * [fit] - How the artboard should be fitted to its layout bounds.
  /// * [alignment] - The alignment of the artboard within its bounds.
  /// * [useArtboardSize] - Whether to use the artboard's dimensions for sizing.
  /// * [antialiasing] - Whether to enable antialiasing.
  /// * [enablePointerEvents] - Whether to enable pointer events on the artboard.
  /// * [cursor] - The mouse cursor to show when hovering over the widget.
  /// * [behavior] - How to behave during hit testing.
  /// * [clipRect] - The rectangle used to clip the artboard.
  /// * [speedMultiplier] - The speed multiplier for the animation.
  /// * [isTouchScrollEnabled] - Whether touch scrolling is enabled.
  /// * [components] - List of components to be modified.
  const RiveColorModifier({
    super.key,
    required this.artboard,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.useArtboardSize = false,
    this.antialiasing = true,
    this.enablePointerEvents = false,
    this.cursor = MouseCursor.defer,
    this.behavior = RiveHitTestBehavior.opaque,
    this.clipRect,
    this.speedMultiplier = 1.0,
    this.isTouchScrollEnabled = false,
    this.components = const [],
  });

  /// Artboard used for drawing
  final Artboard artboard;

  /// Fit for the rendering artboard
  final BoxFit fit;

  /// Alignment for the rendering artboard
  final Alignment alignment;

  /// {@template Rive.useArtboardSize}
  /// Determines whether to use the inherent size of the [artboard], i.e. the
  /// absolute size defined by the artboard, or size the widget based on the
  /// available constraints only (sized by parent).
  ///
  /// Defaults to `false`, i.e. defaults to sizing based on the available
  /// constraints instead of the artboard size.
  ///
  /// When `true`, the artboard size is constrained by the parent constraints.
  /// Using the artboard size has the benefit that the widget now has an
  /// *intrinsic* size.
  ///
  /// When `false`, the intrinsic size is `(0, 0)` because
  /// there is no size intrinsically - it only comes from the parent
  /// constraints. Consequently, if you intend to use the widget in the subtree
  /// of an [IntrinsicWidth] or [IntrinsicHeight] widget or intend to directly
  /// obtain the [RenderBox.getMinIntrinsicWidth] et al., you will want to set
  /// this to `true`.
  /// {@endtemplate}
  final bool useArtboardSize;

  /// Enables/disables antialiasing
  final bool antialiasing;

  /// Enable input listeners (such as hover, pointer down, etc.) on the
  /// artboard.
  ///
  /// Default `false`.
  final bool enablePointerEvents;

  /// The mouse cursor for mouse pointers that are hovering over the region.
  ///
  /// When a mouse enters the region, its cursor will be changed to the
  /// [cursor]. When the mouse leaves the region, the cursor will be decided by
  /// the region found at the new location.
  ///
  /// The [cursor] defaults to [MouseCursor.defer], deferring the choice of
  /// cursor to the next region behind it in hit-test order.
  final MouseCursor cursor;

  /// {@template Rive.behavior}
  /// How to behave during hit testing to consider targets behind this
  /// animation.
  ///
  /// Defaults to [RiveHitTestBehavior.opaque].
  ///
  /// See [RiveHitTestBehavior] for the allowed values and their meanings.
  /// {@endtemplate}
  final RiveHitTestBehavior behavior;

  /// {@template Rive.clipRect}
  /// Clip the artboard to this rect.
  ///
  /// If not supplied it'll default to the constraint size provided by the
  /// parent widget. Unless the [Artboard] has clipping disabled, then no
  /// clip will be applied.
  /// {@endtemplate}
  final Rect? clipRect;

  /// A multiplier for controlling the speed of the Rive animation playback.
  ///
  /// Default `1.0`.
  final double speedMultiplier;

  /// For Rive Listeners, allows scrolling behavior to still occur on Rive
  /// widgets when a touch/drag action is performed on touch-enabled devices.
  /// Otherwise, scroll behavior may be prevented on touch/drag actions on the
  /// widget by default.
  ///
  /// Default `false`.
  final bool isTouchScrollEnabled;

  /// A list of [RiveColorComponent]s that define the color modifications to apply.
  final List<RiveComponent> components;

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
    // Doing this here and not in constructor so it can remain const
    artboard.antialiasing = antialiasing;
    final tickerModeValue = TickerMode.of(context);
    return RiveCustomRenderObject(artboard as RuntimeArtboard)
      ..fit = fit
      ..alignment = alignment
      ..artboardSize = Size(artboard.width, artboard.height)
      ..useArtboardSize = useArtboardSize
      ..clipRect = clipRect
      ..tickerModeEnabled = tickerModeValue
      ..enableHitTests = enablePointerEvents
      ..cursor = cursor
      ..behavior = behavior
      ..speedMultiplier = speedMultiplier
      ..isTouchScrollEnabled = isTouchScrollEnabled
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
    final tickerModeValue = TickerMode.of(context);
    artboard.antialiasing = antialiasing;
    renderObject
      ..artboard = artboard
      ..fit = fit
      ..alignment = alignment
      ..artboardSize = Size(artboard.width, artboard.height)
      ..useArtboardSize = useArtboardSize
      ..clipRect = clipRect
      ..tickerModeEnabled = tickerModeValue
      ..enableHitTests = enablePointerEvents
      ..cursor = cursor
      ..behavior = behavior
      ..speedMultiplier = speedMultiplier
      ..isTouchScrollEnabled = isTouchScrollEnabled
      ..components = components;
  }
}
