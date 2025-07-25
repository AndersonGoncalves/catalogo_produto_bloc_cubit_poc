import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
}
