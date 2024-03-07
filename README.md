# Rive Color Modifier

This package provides an easy and straightforward way to modify the Color of specific Components within [Rive](https://rive.app/) Animations at runtime, while also maintaining their opacity (alpha values) throughout the animation.

## Demo

![rive_color_modifier_example](https://github.com/JSimonDev/rive_color_modifier/assets/124455161/3652c757-d825-4566-a27e-07af0468e2d5)

## Getting started

To start using this package, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  rive_color_modifier: ^1.0.1
```

## Usage

This package allows you to dynamically modify the Color properties of specific components in your Rive Animations. Below is an example demonstrating how to use `RiveColorModifier` along with `RiveColorComponent` to change the color of particular [Shapes](https://help.rive.app/editor/fundamentals/shapes-and-paths) within an animation.

You just have to provide the [Artboard](https://help.rive.app/editor/fundamentals/artboards) of the [Rive](https://rive.app/) asset you are using to the RiveColorModifier, and in the components property, you pass a RiveColorComponent for each Shape you want to change the color of. You also pass the name of the [Fill](https://help.rive.app/editor/fundamentals/fill-and-stroke) or [Stroke](https://help.rive.app/editor/fundamentals/fill-and-stroke) and then the Color you want it to have. Super simple!

```dart
RiveColorModifier(
  artboard: _eyeArtboard,
  components: [
    RiveColorComponent(
      shapeName: 'Eye Pupil Off',
      fillName: 'Pupil Fill',
      color: colors.primary,
    ),
    RiveColorComponent(
      shapeName: 'Eye Border Off',
      strokeName: 'Eye Border Stroke',
      color: colors.primary,
    ),
  ],
)
```

## Additional information

For more information on how to use this package, or if you want to contribute, please visit the [GitHub repository](https://github.com/JSimonDev/rive_color_modifier). If you encounter any issues or have feature requests, please file them in the issue tracker.

Don't forget to like the package if you find it useful, and if you have any suggestion, please let me know.

Your feedback and contributions are welcome to help improve this package!
