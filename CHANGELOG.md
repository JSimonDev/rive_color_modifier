## 2.1.1

### New Features

- Added support for changing both linear and radial gradients with the introduction of the new widget: RiveGradientComponent. This change addresses issue [#1](https://github.com/JSimonDev/rive_color_modifier/issues/1): "Cannot change gradient color"

### Bug Fixes

- Added documentation about the need to enable the "Export Options -> Export all names" setting in Rive when preparing files for use with this package [(#3)](https://github.com/JSimonDev/rive_color_modifier/issues/3)
- Removed the override of didUnmountRenderObject method in RiveColorModifier to prevent framework exceptions during widget disposal [(#4)](https://github.com/JSimonDev/rive_color_modifier/issues/4)

### Documentation

- Updated documentation to include information about exporting names from Rive files.
- Added information about limitations with name exporting in Rive files, particularly for Stroke and Fills elements intended for color changes [(#2)](https://github.com/JSimonDev/rive_color_modifier/issues/2).
- Included a note about potential differences between Rive Pro and non-Pro accounts in terms of export capabilities and their impact on package functionality.

## 2.0.0

### Breaking Changes

- The `shapeName` and `fillName` properties in `RiveColorComponent` have been replaced by `shapePattern`, `fillPattern`, and `strokePattern`. This update allows developers to use regular expressions to match shapes, fills, or strokes based on their names.
- Existing code using `shapeName` and `fillName` will need to be updated to use the new pattern-based properties.

### New Features

- Added `shapePattern`, `fillPattern`, and `strokePattern` properties to the `RiveColorComponent` class.
- These properties allow for more flexible matching using regular expressions.

```Dart
RiveColorComponent(
     shapePattern: '.*',
     fillPattern: '.*primary',
     strokePattern: '.*primary',
     color: primaryColor,
),
```

- Then this component will match every fill or stroke that ends with "primary" in their names.

## 1.0.6

- Update Rive version constraints to "^0.13.1"

## 1.0.5

- Package documentation improvement

## 1.0.3

- You can find a simple demo in the "example" folder

## 1.0.0

- `RiveColorComponent`: Introduces a foundational class to manage and apply color properties within Rive animations. It allows for dynamic color manipulation directly within the Dart code, enhancing the flexibility and interactivity of Rive animations in Flutter apps.

- `RiveColorModifier`: Provides a specialized class to modify and adjust color properties of Rive animations. It focuses on fine-tuned color alteration, enabling developers to implement detailed color transformations and effects on Rive objects.

- `RiveCustomRenderObject`: Implements a custom render object for Rive animations, extending Flutter's RenderBox. This class is designed to offer a tailored rendering approach, accommodating specific or advanced rendering requirements for Rive animations. It allows for enhanced integration of Rive animations with Flutter's rendering engine, ensuring optimized performance and customization.
