import 'package:advanced_widgets/ui/themes/theme.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeColors get themeColors => Theme.of(this).extension<ThemeColors>()!;

  ThemeViewModel get themeViewModel => ThemeViewModel.of(this)!;
}
